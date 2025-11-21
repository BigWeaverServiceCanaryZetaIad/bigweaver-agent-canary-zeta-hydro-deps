use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Join, Iterate};

/// Benchmark connected components computation
fn connected_components_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/connected_components");

    for size in [50, 100, 200].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, edges) = scope.new_collection();

                        // Compute connected components using label propagation
                        let labels = edges.iterate(|inner| {
                            let edges = edges.enter(&inner.scope());

                            // Start with self-labels
                            let labels = edges
                                .map(|(src, _dst)| (src, src))
                                .concat(&edges.map(|(_src, dst)| (dst, dst)))
                                .distinct();

                            // Propagate minimum label
                            labels
                                .join_map(&edges, |_src, &label, &dst| (dst, label))
                                .concat(&labels)
                                .reduce(|_key, input, output| {
                                    let min_label = input.iter().map(|(label, _)| *label).min().unwrap();
                                    output.push((min_label, 1));
                                })
                        });

                        let probe = labels.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Create a graph with multiple components
                    // Component 1: chain
                    for i in 0..(size / 2) {
                        input.insert((i as u64, (i + 1) as u64));
                    }
                    // Component 2: chain
                    for i in (size / 2)..size {
                        input.insert((i as u64, (i + 1) as u64));
                    }

                    input.advance_to(1);
                    input.flush();

                    worker.step_while(|| probe.less_than(input.time()));
                });
            });
        });
    }

    group.finish();
}

/// Benchmark transitive closure computation
fn transitive_closure_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/transitive_closure");

    for size in [50, 100, 200].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, edges) = scope.new_collection();

                        // Compute transitive closure
                        let tc = edges.iterate(|inner| {
                            let edges = edges.enter(&inner.scope());

                            inner
                                .join_map(&edges, |_mid, &src, &dst| (src, dst))
                                .concat(&edges)
                                .distinct()
                        });

                        let probe = tc.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Create a simple chain graph
                    for i in 0..size {
                        input.insert((i as u64, (i + 1) as u64));
                    }

                    input.advance_to(1);
                    input.flush();

                    worker.step_while(|| probe.less_than(input.time()));
                });
            });
        });
    }

    group.finish();
}

criterion_group!(
    benches,
    connected_components_benchmark,
    transitive_closure_benchmark
);
criterion_main!(benches);
