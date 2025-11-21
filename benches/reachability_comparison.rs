//! Graph Reachability Benchmark Comparison
//!
//! Compares graph reachability computation performance between:
//! - Differential Dataflow (incremental computation)
//! - Timely Dataflow (with feedback loops)
//! - Hydroflow (various modes)

use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::io::{BufRead, BufReader, Cursor};
use std::rc::Rc;
use std::sync::LazyLock;

use criterion::{Criterion, criterion_group, criterion_main};

// Load graph data at compile time
static EDGES: LazyLock<HashMap<usize, Vec<usize>>> = LazyLock::new(|| {
    let cursor = Cursor::new(include_bytes!("data/reachability_edges.txt"));
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
    let cursor = Cursor::new(include_bytes!("data/reachability_edges.txt"));
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
    let cursor = Cursor::new(include_bytes!("data/reachability_reachable.txt"));
    let reader = BufReader::new(cursor);

    let mut set = HashSet::new();
    for line in reader.lines() {
        let line = line.unwrap();
        set.insert(line.parse().unwrap());
    }
    set
});

/// Differential Dataflow reachability benchmark
fn benchmark_differential(c: &mut Criterion) {
    use differential_dataflow::operators::*;
    
    c.bench_function("reachability/differential", |b| {
        b.iter(|| {
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

/// Timely Dataflow reachability benchmark with feedback
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Inspect};
    use timely::dataflow::operators::generic::operator::Operator;
    
    c.bench_function("reachability/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                use timely::dataflow::operators::Concatenate;
                use timely::dataflow::operators::feedback::Feedback;
                
                let edges = &*EDGES;
                
                // Create feedback loop
                let (handle, cycle) = scope.feedback(1);
                
                // Initial reachable vertices
                let initial = vec![1].to_stream(scope);
                
                // Combine initial vertices with feedback
                let reachable = scope.concatenate(vec![initial, cycle]);
                
                // Find neighbors and filter duplicates
                let next = reachable.unary_notify(
                    timely::dataflow::channels::pact::Pipeline,
                    "reachability",
                    None,
                    move |input, output, _notificator| {
                        let mut seen = HashSet::new();
                        input.for_each(|time, data| {
                            let mut session = output.session(&time);
                            for v in data.iter().cloned() {
                                if seen.insert(v) {
                                    if let Some(neighbors) = edges.get(&v) {
                                        for &neighbor in neighbors {
                                            session.give(neighbor);
                                        }
                                    }
                                }
                            }
                        });
                    },
                );
                
                next.inspect(|_| {}).connect_loop(handle);
            });
        });
    });
}

/// Hydroflow reachability benchmark
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    let edges = &*EDGES;
    let reachable = &*REACHABLE;

    c.bench_function("reachability/hydroflow", |b| {
        b.iter_batched(
            || {
                let reachable_verts = Rc::new(RefCell::new(HashSet::new()));

                let df = {
                    let reachable_inner = reachable_verts.clone();

                    dfir_syntax! {
                        origin = source_iter([1]);
                        reached_vertices = union();
                        origin -> reached_vertices;

                        my_cheaty_join = reached_vertices 
                            -> filter_map(|v| edges.get(&v)) 
                            -> flatten() 
                            -> map(|&v| v);
                        my_cheaty_join 
                            -> filter(|&v| reachable_inner.borrow_mut().insert(v)) 
                            -> reached_vertices;
                    }
                };

                (df, reachable_verts)
            },
            |(mut df, reachable_verts)| {
                df.run_available_sync();
                assert_eq!(&*reachable_verts.borrow(), reachable);
            },
            criterion::BatchSize::LargeInput,
        );
    });
}

/// Baseline: Sequential BFS
fn benchmark_baseline_bfs(c: &mut Criterion) {
    use std::collections::VecDeque;
    
    let edges = &*EDGES;
    let expected = &*REACHABLE;
    
    c.bench_function("reachability/baseline", |b| {
        b.iter(|| {
            let mut visited = HashSet::new();
            let mut queue = VecDeque::new();
            
            queue.push_back(1);
            visited.insert(1);
            
            while let Some(node) = queue.pop_front() {
                if let Some(neighbors) = edges.get(&node) {
                    for &neighbor in neighbors {
                        if visited.insert(neighbor) {
                            queue.push_back(neighbor);
                        }
                    }
                }
            }
            
            assert_eq!(&visited, expected);
        });
    });
}

criterion_group!(
    reachability_comparison,
    benchmark_differential,
    benchmark_timely,
    benchmark_hydroflow,
    benchmark_baseline_bfs,
);
criterion_main!(reachability_comparison);
