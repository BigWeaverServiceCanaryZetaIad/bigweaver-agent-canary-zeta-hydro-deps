// Reachability benchmark for differential dataflow
// Tests graph traversal using iterative computation

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Iterate, Join, Distinct};

fn reachability_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_reachability");
    
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
                    let mut reachable_count = 0;
                    let (mut roots_input, mut edges_input, probe) = worker.dataflow(|scope| {
                        let (roots_input, roots) = scope.new_collection::<usize>();
                        let (edges_input, edges) = scope.new_collection::<(usize, usize)>();
                        
                        let result = roots.iterate(|reachable| {
                            let edges = edges.enter(&reachable.scope());
                            edges
                                .join_map(&reachable, |_src, &dst, _| dst)
                                .concat(&reachable)
                                .distinct()
                        })
                        .inspect(move |_| reachable_count += 1);
                        
                        (roots_input, edges_input, result.probe())
                    });
                    
                    // Insert starting node
                    roots_input.insert(0);
                    roots_input.advance_to(1);
                    roots_input.flush();
                    
                    // Insert edges
                    for (src, dst) in edges {
                        edges_input.insert((src, dst));
                    }
                    edges_input.advance_to(1);
                    edges_input.flush();
                    
                    worker.step_while(|| probe.less_than(&1));
                    black_box(reachable_count);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, reachability_benchmark);
criterion_main!(benches);
