use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Reduce;
use rand::Rng;

/// Benchmark distinct operation with various cardinalities
fn distinct_operation_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/distinct");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        let distinct = collection.distinct();

                        let probe = distinct.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Insert data with duplicates (10% unique values)
                    for i in 0..size {
                        let value = (i % (size / 10)) as u64;
                        input.insert(value);
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

/// Benchmark distinct with high cardinality
fn distinct_high_cardinality_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/distinct_high_cardinality");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        let distinct = collection.distinct();

                        let probe = distinct.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Insert mostly unique data (90% unique)
                    let mut rng = rand::thread_rng();
                    for i in 0..size {
                        let value = if rng.gen_bool(0.9) {
                            i as u64
                        } else {
                            (i % 100) as u64
                        };
                        input.insert(value);
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

/// Benchmark incremental distinct updates
fn incremental_distinct_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/incremental_distinct");

    for size in [1000, 5000, 10000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input, mut probe) = worker.dataflow(|scope| {
                        let (input_handle, collection) = scope.new_collection();

                        let distinct = collection.distinct();

                        let probe = distinct.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input_handle, probe)
                    });

                    // Initial data
                    for i in 0..size {
                        let value = (i % 100) as u64;
                        input.insert(value);
                    }
                    input.advance_to(1);
                    input.flush();

                    worker.step_while(|| probe.less_than(input.time()));

                    // Incremental updates - add new values
                    for i in 0..100 {
                        input.insert((size + i) as u64);
                    }
                    input.advance_to(2);
                    input.flush();

                    worker.step_while(|| probe.less_than(input.time()));

                    // Remove some values
                    for i in 0..50 {
                        input.remove(i as u64);
                    }
                    input.advance_to(3);
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
    distinct_operation_benchmark,
    distinct_high_cardinality_benchmark,
    incremental_distinct_benchmark
);
criterion_main!(benches);
