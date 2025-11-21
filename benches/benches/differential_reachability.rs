mod common;

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::{Iterate, Join, Threshold};
use timely::dataflow::operators::Probe;

fn differential_reachability_chain(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/reachability/chain");
    
    for size in [100, 500, 1_000].iter() {
        let edges = common::generate_chain_graph(*size);
        group.throughput(Throughput::Elements(*size as u64));
        
        group.bench_with_input(BenchmarkId::from_parameter(size), &edges, |b, edges| {
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut edge_input = InputSession::new();
                    let mut root_input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let edges = edge_input.to_collection(scope);
                        let roots = root_input.to_collection(scope).map(|x| (x, ()));

                        roots
                            .iterate(|reachable| {
                                let edges = edges.enter(&reachable.scope());
                                reachable
                                    .map(|(node, _)| node)
                                    .join_map(&edges, |_src, _, dst| (*dst, ()))
                                    .concat(&roots.enter(&reachable.scope()))
                                    .distinct()
                            })
                            .probe_with(&mut probe);
                    });

                    for edge in edges.iter() {
                        edge_input.insert(black_box(*edge));
                    }
                    root_input.insert(0);
                    
                    edge_input.advance_to(1);
                    root_input.advance_to(1);
                    edge_input.flush();
                    root_input.flush();
                    
                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_reachability_random(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/reachability/random");
    
    for (nodes, edges_count) in [(50, 200), (100, 500), (200, 1000)].iter() {
        let edges = common::generate_random_graph(*nodes, *edges_count, 12345);
        group.throughput(Throughput::Elements(*edges_count as u64));
        
        let label = format!("{}nodes_{}edges", nodes, edges_count);
        group.bench_with_input(BenchmarkId::from_parameter(&label), &edges, |b, edges| {
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut edge_input = InputSession::new();
                    let mut root_input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let edges = edge_input.to_collection(scope);
                        let roots = root_input.to_collection(scope).map(|x| (x, ()));

                        roots
                            .iterate(|reachable| {
                                let edges = edges.enter(&reachable.scope());
                                reachable
                                    .map(|(node, _)| node)
                                    .join_map(&edges, |_src, _, dst| (*dst, ()))
                                    .concat(&roots.enter(&reachable.scope()))
                                    .distinct()
                            })
                            .probe_with(&mut probe);
                    });

                    for edge in edges.iter() {
                        edge_input.insert(black_box(*edge));
                    }
                    root_input.insert(0);
                    
                    edge_input.advance_to(1);
                    root_input.advance_to(1);
                    edge_input.flush();
                    root_input.flush();
                    
                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_incremental_reachability(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/reachability/incremental");
    
    for size in [100, 200].iter() {
        let edges = common::generate_chain_graph(*size);
        group.throughput(Throughput::Elements(*size as u64));
        
        group.bench_with_input(BenchmarkId::from_parameter(size), &edges, |b, edges| {
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut edge_input = InputSession::new();
                    let mut root_input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let edges = edge_input.to_collection(scope);
                        let roots = root_input.to_collection(scope).map(|x| (x, ()));

                        roots
                            .iterate(|reachable| {
                                let edges = edges.enter(&reachable.scope());
                                reachable
                                    .map(|(node, _)| node)
                                    .join_map(&edges, |_src, _, dst| (*dst, ()))
                                    .concat(&roots.enter(&reachable.scope()))
                                    .distinct()
                            })
                            .probe_with(&mut probe);
                    });

                    // Initial batch - first half of edges
                    for edge in edges.iter().take(edges.len() / 2) {
                        edge_input.insert(*edge);
                    }
                    root_input.insert(0);
                    edge_input.advance_to(1);
                    root_input.advance_to(1);
                    edge_input.flush();
                    root_input.flush();
                    while probe.less_than(&1) {
                        worker.step();
                    }
                    
                    // Incremental update - second half
                    for edge in edges.iter().skip(edges.len() / 2) {
                        edge_input.insert(black_box(*edge));
                    }
                    edge_input.advance_to(2);
                    edge_input.flush();
                    while probe.less_than(&2) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

criterion_group!(
    benches,
    differential_reachability_chain,
    differential_reachability_random,
    differential_incremental_reachability
);
criterion_main!(benches);
