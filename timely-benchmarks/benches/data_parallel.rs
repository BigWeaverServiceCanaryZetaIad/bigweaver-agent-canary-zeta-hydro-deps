use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::operators::{Inspect, Map, ToStream};
use timely::dataflow::{InputHandle, ProbeHandle};

/// Benchmark basic data-parallel operations in timely
fn map_operation_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/data_parallel/map");

    for size in [10000, 50000, 100000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .map(|x| x * 2)
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();

                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }

    group.finish();
}

/// Benchmark filter operations
fn filter_operation_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/data_parallel/filter");

    for size in [10000, 50000, 100000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .filter(|x| x % 2 == 0)
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();

                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }

    group.finish();
}

/// Benchmark flat_map operations
fn flat_map_operation_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/data_parallel/flat_map");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .flat_map(|x| vec![x, x * 2, x * 3])
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();

                    while probe.less_than(&1) {
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
    map_operation_benchmark,
    filter_operation_benchmark,
    flat_map_operation_benchmark
);
criterion_main!(benches);
