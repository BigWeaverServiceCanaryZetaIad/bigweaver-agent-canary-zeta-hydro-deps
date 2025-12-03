/// Graph reachability benchmarks using differential-dataflow
/// 
/// This benchmark suite evaluates graph algorithms and iterative
/// computations common in distributed dataflow systems.

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Iterate, Join, Threshold};
use timely::dataflow::operators::Map;

fn bench_reachability_small(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_reachability");
    
    // Small graph: 10 nodes, ~20 edges
    let edges: Vec<(u32, u32)> = vec![
        (0, 1), (1, 2), (2, 3), (3, 4),
        (0, 5), (5, 6), (6, 7), (7, 8),
        (1, 6), (2, 7), (3, 8), (4, 9),
        (5, 1), (6, 2), (7, 3), (8, 4),
        (0, 9), (9, 0), (4, 0), (8, 0),
    ];
    
    group.throughput(Throughput::Elements(edges.len() as u64));
    group.bench_function("small_graph", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                let edges = black_box(edges.clone());
                worker.dataflow::<(), _, _>(|scope| {
                    let (edge_input, edges) = scope.new_collection();
                    let (root_input, roots) = scope.new_collection();
                    
                    // Compute reachable nodes from roots
                    let reachable = roots.iterate(|inner| {
                        let edges = edges.enter(&inner.scope());
                        inner
                            .join(&edges)
                            .map(|(_src, dst)| dst)
                            .concat(&edges.map(|(src, _dst)| src))
                            .threshold(|_, _| 1)
                    });
                    
                    // Materialize to force computation
                    reachable.inspect(|_| {});
                    
                    // Insert data
                    edge_input.extend(edges.into_iter().map(|e| (e, 1)));
                    root_input.insert(0);
                });
            });
        });
    });
    
    group.finish();
}

fn bench_reachability_medium(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_reachability");
    
    // Medium graph: 100 nodes, chain structure
    let edges: Vec<(u32, u32)> = (0..99).map(|i| (i, i + 1)).collect();
    
    group.throughput(Throughput::Elements(edges.len() as u64));
    group.bench_function("medium_graph", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                let edges = black_box(edges.clone());
                worker.dataflow::<(), _, _>(|scope| {
                    let (edge_input, edges) = scope.new_collection();
                    let (root_input, roots) = scope.new_collection();
                    
                    let reachable = roots.iterate(|inner| {
                        let edges = edges.enter(&inner.scope());
                        inner
                            .join(&edges)
                            .map(|(_src, dst)| dst)
                            .concat(&edges.map(|(src, _dst)| src))
                            .threshold(|_, _| 1)
                    });
                    
                    reachable.inspect(|_| {});
                    
                    edge_input.extend(edges.into_iter().map(|e| (e, 1)));
                    root_input.insert(0);
                });
            });
        });
    });
    
    group.finish();
}

fn bench_reachability_dense(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_reachability");
    
    // Dense graph: 20 nodes, many edges
    let mut edges = Vec::new();
    for i in 0..20 {
        for j in 0..20 {
            if i != j && (i + j) % 3 != 0 {
                edges.push((i, j));
            }
        }
    }
    
    group.throughput(Throughput::Elements(edges.len() as u64));
    group.bench_function("dense_graph", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                let edges = black_box(edges.clone());
                worker.dataflow::<(), _, _>(|scope| {
                    let (edge_input, edges) = scope.new_collection();
                    let (root_input, roots) = scope.new_collection();
                    
                    let reachable = roots.iterate(|inner| {
                        let edges = edges.enter(&inner.scope());
                        inner
                            .join(&edges)
                            .map(|(_src, dst)| dst)
                            .concat(&edges.map(|(src, _dst)| src))
                            .threshold(|_, _| 1)
                    });
                    
                    reachable.inspect(|_| {});
                    
                    edge_input.extend(edges.into_iter().map(|e| (e, 1)));
                    root_input.insert(0);
                });
            });
        });
    });
    
    group.finish();
}

criterion_group!(
    benches,
    bench_reachability_small,
    bench_reachability_medium,
    bench_reachability_dense
);
criterion_main!(benches);
