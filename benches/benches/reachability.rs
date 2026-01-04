use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::io::{BufRead, BufReader, Cursor};
use std::rc::Rc;
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
            let edges = edges.clone();
            let receiver = timely::example(|scope| {
                let mut seen = HashSet::new();

                let (handle, stream) = scope.feedback(1);

                let stream_out = (1_usize..=1)
                    .to_stream(scope)
                    .concat(&stream)
                    .flat_map(move |x| edges.get(&x).cloned().into_iter().flatten())
                    .filter(move |x| seen.insert(*x));
                stream_out.connect_loop(handle);

                stream_out.capture()
            });

            let reached: HashSet<_> = receiver
                .iter()
                .filter_map(|e| match e {
                    timely::dataflow::operators::capture::event::Event::Messages(_, vec) => {
                        Some(vec)
                    }
                    _ => None,
                })
                .flatten()
                .collect();

            assert_eq!(&reached, reachable);
        });
    });
}
fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("reachability/differential", |b| {
        b.iter(move || {
            timely::execute_directly(move |worker| {
                let probe = worker.dataflow::<u32, _, _>(|scope| {
                    let edges = scope.new_collection_from(EDGE_VEC.iter().cloned()).1;
                    let roots = scope.new_collection_from(vec![1]).1;

                    let reachable = roots.iterate(|reach| {
                        edges
                            .enter(&reach.scope())
                            .semijoin(reach)
                            .map(|(_src, dst)| dst)
                            .concat(reach)
                            .distinct()
                    });

                    reachable.probe()
                });

                worker.step_while(|| !probe.done());
            });
        });
    });
}

criterion_group!(
    reachability,
    benchmark_timely,
    benchmark_differential,
);
criterion_main!(reachability);
