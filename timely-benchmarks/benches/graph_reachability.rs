use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::channels::pact::Pipeline;
use timely::dataflow::operators::{Concat, Inspect, Map, ToStream};
use timely::dataflow::{InputHandle, ProbeHandle};

/// Graph reachability benchmark using timely dataflow
/// This benchmark computes reachable nodes in a graph using iterative dataflow
fn graph_reachability_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/graph_reachability");

    for size in [100, 1000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = ProbeHandle::new();

                    // Build the dataflow graph
                    worker.dataflow(|scope| {
                        let edges = input.to_stream(scope);

                        // Start with node 0 as the root
                        let roots = vec![0u64].to_stream(scope);

                        // Iterative reachability computation
                        let reachable = scope.iterative::<u64, _, _>(|inner| {
                            let edges = edges.enter(inner);
                            let roots = roots.enter(inner);

                            // Start with roots, join with edges to find next level
                            let next = roots
                                .map(|x| (x, ()))
                                .join_map(&edges, |_src, &(), &dst| dst)
                                .concat(&roots)
                                .distinct();

                            next.leave()
                        });

                        reachable
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    // Generate a simple chain graph: 0 -> 1 -> 2 -> ... -> size-1
                    for i in 0..size {
                        input.send((i as u64, (i + 1) as u64));
                    }
                    input.advance_to(1);
                    input.flush();

                    // Run until complete
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }

    group.finish();
}

/// Simple join benchmark to test data shuffling
fn join_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/join");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input1 = InputHandle::new();
                    let mut input2 = InputHandle::new();
                    let mut probe = ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let stream1 = input1.to_stream(scope);
                        let stream2 = input2.to_stream(scope);

                        stream1
                            .join_map(&stream2, |&key, &val1, &val2| (key, val1, val2))
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    // Send matching data
                    for i in 0..size {
                        input1.send((i as u64, i as u64 * 2));
                        input2.send((i as u64, i as u64 * 3));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input1.flush();
                    input2.flush();

                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }

    group.finish();
}

criterion_group!(benches, graph_reachability_benchmark, join_benchmark);
criterion_main!(benches);
