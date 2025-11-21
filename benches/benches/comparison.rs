mod common;

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::Count;
use timely::dataflow::operators::{Map, Probe};
use timely::dataflow::InputHandle;

fn compare_map_operations(c: &mut Criterion) {
    let mut group = c.benchmark_group("comparison/map");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        
        // Timely version
        group.bench_with_input(
            BenchmarkId::new("timely", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputHandle::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_stream(scope)
                                .map(|x: u64| black_box(x * 2))
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.send(i as u64);
                        }
                        input.advance_to(1);
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
        
        // Differential version
        group.bench_with_input(
            BenchmarkId::new("differential", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputSession::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_collection(scope)
                                .map(|x: u64| black_box(x * 2))
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.insert(i as u64);
                        }
                        input.advance_to(1);
                        input.flush();
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
    }
    group.finish();
}

fn compare_filter_operations(c: &mut Criterion) {
    let mut group = c.benchmark_group("comparison/filter");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        
        // Timely version
        group.bench_with_input(
            BenchmarkId::new("timely", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputHandle::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            use timely::dataflow::operators::Filter;
                            input
                                .to_stream(scope)
                                .filter(|x: &u64| black_box(*x % 2 == 0))
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.send(i as u64);
                        }
                        input.advance_to(1);
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
        
        // Differential version
        group.bench_with_input(
            BenchmarkId::new("differential", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputSession::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_collection(scope)
                                .filter(|x: &u64| black_box(*x % 2 == 0))
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.insert(i as u64);
                        }
                        input.advance_to(1);
                        input.flush();
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
    }
    group.finish();
}

fn compare_aggregation(c: &mut Criterion) {
    let mut group = c.benchmark_group("comparison/aggregation");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        
        // Timely version (using fold-like pattern)
        group.bench_with_input(
            BenchmarkId::new("timely_accumulate", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputHandle::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            use timely::dataflow::operators::Accumulate;
                            input
                                .to_stream(scope)
                                .accumulate(0u64, |sum, data| {
                                    for val in data.iter() {
                                        *sum += black_box(*val);
                                    }
                                })
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.send(i as u64 % 100);
                        }
                        input.advance_to(1);
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
        
        // Differential version (using count)
        group.bench_with_input(
            BenchmarkId::new("differential_count", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputSession::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_collection(scope)
                                .count()
                                .probe_with(&mut probe);
                        });

                        for i in 0..size {
                            input.insert(black_box(i as u64 % 100));
                        }
                        input.advance_to(1);
                        input.flush();
                        while probe.less_than(input.time()) {
                            worker.step();
                        }
                    });
                });
            },
        );
    }
    group.finish();
}

fn compare_reachability(c: &mut Criterion) {
    let mut group = c.benchmark_group("comparison/reachability");
    
    for size in [100, 200].iter() {
        let edges = common::generate_chain_graph(*size);
        group.throughput(Throughput::Elements(*size as u64));
        
        // Differential version (more natural for graph algorithms)
        group.bench_with_input(
            BenchmarkId::new("differential", size),
            &edges,
            |b, edges| {
                b.iter(|| {
                    let edges = edges.clone();
                    timely::execute_directly(move |worker| {
                        let mut edge_input = InputSession::new();
                        let mut root_input = InputSession::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            use differential_dataflow::operators::Iterate;
                            let edges = edge_input.to_collection(scope);
                            let roots = root_input.to_collection(scope).map(|x| (x, ()));

                            roots
                                .iterate(|reachable| {
                                    let edges = edges.enter(&reachable.scope());
                                    use differential_dataflow::operators::Join;
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
            },
        );
    }
    group.finish();
}

fn compare_incremental_update(c: &mut Criterion) {
    let mut group = c.benchmark_group("comparison/incremental");
    
    for size in [1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64 + 100));
        
        // Only Differential - this is where it shines
        group.bench_with_input(
            BenchmarkId::new("differential_advantage", size),
            size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputSession::new();
                        let mut probe = timely::dataflow::ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_collection(scope)
                                .map(|x: u64| (x % 100, x))
                                .count()
                                .probe_with(&mut probe);
                        });

                        // Initial batch
                        for i in 0..size {
                            input.insert(i as u64);
                        }
                        input.advance_to(1);
                        input.flush();
                        while probe.less_than(&1) {
                            worker.step();
                        }
                        
                        // Small incremental update - differential should excel here
                        for i in 0..100 {
                            input.insert(black_box(i as u64));
                        }
                        input.advance_to(2);
                        input.flush();
                        while probe.less_than(&2) {
                            worker.step();
                        }
                    });
                });
            },
        );
    }
    group.finish();
}

criterion_group!(
    benches,
    compare_map_operations,
    compare_filter_operations,
    compare_aggregation,
    compare_reachability,
    compare_incremental_update
);
criterion_main!(benches);
