use std::collections::{HashMap, HashSet};
use std::io::{BufRead, BufReader, Cursor};
use std::sync::LazyLock;

use criterion::{Criterion, criterion_group, criterion_main};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Iterate, Join, Threshold};

static EDGES: LazyLock<HashMap<usize, Vec<usize>>> = LazyLock::new(|| {
    let cursor = Cursor::new(include_bytes!("reachability_edges.txt"));
    let reader = BufReader::new(cursor);

    let mut edges = HashMap::<_, Vec<_>>::new();
    for line in reader.lines() {
        let line = line.unwrap();
        let mut nums = line.split_whitespace();
        let a = nums.next().unwrap().parse().unwrap();
        let b = nums.next().unwrap().parse().unwrap();
        assert!(nums.next().is_none());
        edges.entry(a).or_default().push(b);
    }
    edges
});
static EDGE_VEC: LazyLock<Vec<(usize, usize)>> = LazyLock::new(|| {
    let cursor = Cursor::new(include_bytes!("reachability_edges.txt"));
    let reader = BufReader::new(cursor);

    reader
        .lines()
        .map(|line| {
            let line = line.unwrap();
            let mut v = line.split_whitespace().map(|n| n.parse::<usize>().unwrap());
            (v.next().unwrap(), v.next().unwrap())
        })
        .collect()
});
static REACHABLE: LazyLock<HashSet<usize>> = LazyLock::new(|| {
    let cursor = Cursor::new(include_bytes!("reachability_reachable.txt"));
    let reader = BufReader::new(cursor);

    let mut set = HashSet::new();
    for line in reader.lines() {
        let line = line.unwrap();
        set.insert(line.parse().unwrap());
    }
    set
});

fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{
        Capture, Concat, ConnectLoop, Feedback, Filter, Map, ToStream,
    };

    let edges = &*EDGES;
    let reachable = &*REACHABLE;

    c.bench_function("reachability/timely", |b| {
        b.iter(|| {
            let captured = timely::example(|scope| {
                let (handle, cycle) = scope.feedback(1);

                let roots = vec![0usize].to_stream(scope);

                roots
                    .concat(&cycle)
                    .map(move |node| {
                        edges
                            .get(&node)
                            .into_iter()
                            .flat_map(|v| v.iter().copied())
                            .collect::<Vec<_>>()
                    })
                    .flat_map(|x: Vec<usize>| x)
                    .filter(|n| reachable.contains(n))
                    .connect_loop(handle);
            })
            .capture();

            // Consume captured to prevent unused variable warning
            drop(captured);
        })
    });
}

fn benchmark_differential(c: &mut Criterion) {
    let edges = &*EDGE_VEC;
    let reachable = &*REACHABLE;

    c.bench_function("reachability/differential", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                let mut roots = worker.dataflow::<(), _, _>(|scope| {
                    let (root_input, roots) = scope.new_collection::<usize, isize>();

                    let (edge_input, edges) = scope.new_collection::<(usize, usize), isize>();

                    let reachable = roots.iterate(|inner| {
                        let edges = edges.enter(&inner.scope());
                        let roots = roots.enter(&inner.scope());

                        roots
                            .concat(
                                &inner
                                    .join_map(&edges, |_k, &(), &v| v)
                                    .filter(|n| reachable.contains(n)),
                            )
                            .distinct()
                    });

                    (root_input, edge_input, reachable.consolidate())
                });

                roots.0.insert(0);
                roots.0.close();

                for &(a, b) in edges {
                    roots.1.insert((a, b));
                }
                roots.1.close();

                worker.step_while(|| worker.pending());
            });
        })
    });
}

criterion_group!(
    reachability,
    benchmark_timely,
    benchmark_differential,
);
criterion_main!(reachability);
