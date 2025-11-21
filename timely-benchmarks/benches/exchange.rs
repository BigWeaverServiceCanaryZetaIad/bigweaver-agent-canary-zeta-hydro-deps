use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::channels::pact::Exchange;
use timely::dataflow::operators::{Inspect, ToStream};
use timely::dataflow::{InputHandle, ProbeHandle};

/// Benchmark data exchange/shuffling performance
fn exchange_pattern_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/exchange");

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
                            .unary(
                                Exchange::new(|x: &u64| *x),
                                "Exchange",
                                |_capability, _info| {
                                    move |input, output| {
                                        input.for_each(|time, data| {
                                            let mut session = output.session(&time);
                                            for datum in data.iter() {
                                                session.give(*datum);
                                            }
                                        });
                                    }
                                },
                            )
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

/// Benchmark hash-based partitioning
fn hash_partition_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/hash_partition");

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
                            .unary(
                                Exchange::new(|x: &(u64, u64)| x.0),
                                "HashPartition",
                                |_capability, _info| {
                                    move |input, output| {
                                        input.for_each(|time, data| {
                                            let mut session = output.session(&time);
                                            for datum in data.iter() {
                                                session.give(*datum);
                                            }
                                        });
                                    }
                                },
                            )
                            .inspect(|x| {
                                black_box(x);
                            })
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send((i as u64 % 100, i as u64));
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

criterion_group!(benches, exchange_pattern_benchmark, hash_partition_benchmark);
criterion_main!(benches);
