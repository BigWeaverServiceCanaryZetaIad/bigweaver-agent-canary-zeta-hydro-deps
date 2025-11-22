// Reachability benchmark for timely dataflow
// Tests graph traversal patterns

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Inspect, ToStream};
use std::collections::HashSet;

fn reachability_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_reachability");
    
    for size in [100, 500, 1_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            // Create a simple graph: linear chain with some cross-edges
            let edges: Vec<(usize, usize)> = (0..size)
                .flat_map(|i| {
                    let mut e = vec![(i, i + 1)];
                    if i % 10 == 0 && i + 10 < size {
                        e.push((i, i + 10));
                    }
                    e
                })
                .collect();
            
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut reachable = HashSet::new();
                    worker.dataflow(|scope| {
                        edges
                            .to_stream(scope)
                            .inspect(move |(src, dst)| {
                                reachable.insert(*src);
                                reachable.insert(*dst);
                            });
                    });
                    black_box(reachable.len());
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, reachability_benchmark);
criterion_main!(benches);
