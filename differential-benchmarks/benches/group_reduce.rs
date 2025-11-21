use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Reduce;

/// Benchmark group-by and aggregation operations
fn group_by_sum_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/group_by_sum");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        // Group by key and sum values
                        let aggregated = collection.reduce(|_key, input, output| {
                            let sum: i64 = input.iter().map(|(val, _)| *val).sum();
                            output.push((sum, 1));
                        });

                        let probe = aggregated.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Insert data with keys that will be grouped
                    for i in 0..size {
                        let key = (i % 100) as u64;  // 100 distinct keys
                        let value = i as i64;
                        input.insert((key, value));
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

/// Benchmark count aggregation
fn group_by_count_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/group_by_count");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        // Group by key and count
                        let counts = collection
                            .map(|(key, _val)| key)
                            .count();

                        let probe = counts.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Insert data
                    for i in 0..size {
                        let key = (i % 100) as u64;
                        let value = i as u64;
                        input.insert((key, value));
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

/// Benchmark incremental aggregation with updates
fn incremental_aggregation_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/incremental_aggregation");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        let aggregated = collection.reduce(|_key, input, output| {
                            let sum: i64 = input.iter().map(|(val, _)| *val).sum();
                            let count = input.len();
                            output.push((sum / count as i64, 1));  // Average
                        });

                        let probe = aggregated.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Initial insertion
                    for i in 0..size {
                        let key = (i % 100) as u64;
                        let value = i as i64;
                        input.insert((key, value));
                    }
                    input.advance_to(1);
                    input.flush();

                    worker.step_while(|| probe.less_than(input.time()));

                    // Incremental updates
                    for i in 0..100 {
                        input.remove((i as u64, i as i64));
                        input.insert((i as u64, (i * 2) as i64));
                    }
                    input.advance_to(2);
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
    group_by_sum_benchmark,
    group_by_count_benchmark,
    incremental_aggregation_benchmark
);
criterion_main!(benches);
