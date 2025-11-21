use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::operators::{Inspect, ToStream};
use timely::dataflow::{InputHandle, ProbeHandle};

/// Benchmark barrier synchronization performance
fn barrier_synchronization_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/barrier_sync");

    for num_barriers in [10, 50, 100].iter() {
        group.throughput(Throughput::Elements(*num_barriers as u64));
        group.bench_with_input(
            BenchmarkId::from_parameter(num_barriers),
            num_barriers,
            |b, &num_barriers| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputHandle::new();
                        let mut probe = ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_stream(scope)
                                .inspect(|x| {
                                    black_box(x);
                                })
                                .probe_with(&mut probe);
                        });

                        // Send data and advance through multiple barriers
                        for barrier in 0..num_barriers {
                            input.send(barrier as u64);
                            input.advance_to(barrier + 1);
                            input.flush();

                            while probe.less_than(&(barrier + 1)) {
                                worker.step();
                            }
                        }
                    });
                });
            },
        );
    }

    group.finish();
}

/// Benchmark multiple epoch advancement
fn epoch_advancement_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/epoch_advancement");

    for batch_size in [100, 500, 1000].iter() {
        group.throughput(Throughput::Elements(*batch_size as u64));
        group.bench_with_input(
            BenchmarkId::from_parameter(batch_size),
            batch_size,
            |b, &batch_size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut input = InputHandle::new();
                        let mut probe = ProbeHandle::new();

                        worker.dataflow(|scope| {
                            input
                                .to_stream(scope)
                                .inspect(|x| {
                                    black_box(x);
                                })
                                .probe_with(&mut probe);
                        });

                        // Send batch of data in each epoch
                        for epoch in 0..10 {
                            for i in 0..batch_size {
                                input.send((epoch * batch_size + i) as u64);
                            }
                            input.advance_to(epoch + 1);
                            input.flush();

                            while probe.less_than(&(epoch + 1)) {
                                worker.step();
                            }
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
    barrier_synchronization_benchmark,
    epoch_advancement_benchmark
);
criterion_main!(benches);
