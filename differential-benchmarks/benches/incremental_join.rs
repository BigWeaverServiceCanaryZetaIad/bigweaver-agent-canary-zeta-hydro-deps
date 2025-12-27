use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Join;

/// Benchmark incremental join operations in differential dataflow
fn incremental_join_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/incremental_join");

    for size in [100, 500, 1000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input1, mut input2, mut probe) = worker.dataflow(|scope| {
                        let (input1_handle, input1) = scope.new_collection();
                        let (input2_handle, input2) = scope.new_collection();

                        let joined = input1.join(&input2);
                        let probe = joined.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input1_handle, input2_handle, probe)
                    });

                    // Initial data insertion
                    for i in 0..size {
                        input1.insert((i as u64, i as u64 * 2));
                        input2.insert((i as u64, i as u64 * 3));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input1.flush();
                    input2.flush();

                    worker.step_while(|| probe.less_than(input1.time()));

                    // Incremental updates
                    for i in 0..10 {
                        let idx = (size / 10) * i;
                        input1.insert((idx as u64, idx as u64 * 5));
                    }
                    input1.advance_to(2);
                    input1.flush();

                    worker.step_while(|| probe.less_than(input1.time()));
                });
            });
        });
    }

    group.finish();
}

/// Benchmark multi-way join performance
fn multi_way_join_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/multi_way_join");

    for size in [100, 500, 1000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let (mut input1, mut input2, mut input3, mut probe) = worker.dataflow(|scope| {
                        let (input1_handle, input1) = scope.new_collection();
                        let (input2_handle, input2) = scope.new_collection();
                        let (input3_handle, input3) = scope.new_collection();

                        // Three-way join: input1 ⋈ input2 ⋈ input3
                        let joined = input1
                            .join(&input2)
                            .map(|(k, (v1, v2))| (k, (v1, v2)))
                            .join(&input3.map(|(k, v)| (k, v)))
                            .map(|(k, ((v1, v2), v3))| (k, v1, v2, v3));

                        let probe = joined.inspect(|x| {
                            black_box(x);
                        }).probe();

                        (input1_handle, input2_handle, input3_handle, probe)
                    });

                    // Insert data
                    for i in 0..size {
                        input1.insert((i as u64, i as u64));
                        input2.insert((i as u64, i as u64 * 2));
                        input3.insert((i as u64, i as u64 * 3));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input3.advance_to(1);
                    input1.flush();
                    input2.flush();
                    input3.flush();

                    worker.step_while(|| probe.less_than(input1.time()));
                });
            });
        });
    }

    group.finish();
}

criterion_group!(benches, incremental_join_benchmark, multi_way_join_benchmark);
criterion_main!(benches);
