/// Common dataflow pattern benchmarks for performance comparison
/// 
/// This benchmark suite tests typical distributed dataflow patterns including
/// aggregations, joins, and windowing operations.

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Count, Join, Reduce};
use timely::dataflow::operators::{Map, ToStream};

fn bench_count_operation(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_count");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).map(|i| i % 10).collect();
                    worker.dataflow::<(), _, _>(|scope| {
                        let (input, collection) = scope.new_collection();
                        
                        collection
                            .count()
                            .inspect(|_| {});
                        
                        input.extend(data.into_iter().map(|x| (black_box(x), 1)));
                    });
                });
            });
        });
    }
    group.finish();
}

fn bench_join_operation(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_join");
    
    for size in [100, 1_000, 5_000].iter() {
        group.throughput(Throughput::Elements(*size as u64 * 2));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let left_data: Vec<_> = (0..size).map(|i| (i % 10, i)).collect();
                    let right_data: Vec<_> = (0..size).map(|i| (i % 10, i * 2)).collect();
                    
                    worker.dataflow::<(), _, _>(|scope| {
                        let (left_input, left) = scope.new_collection();
                        let (right_input, right) = scope.new_collection();
                        
                        left.join(&right)
                            .inspect(|_| {});
                        
                        left_input.extend(left_data.into_iter().map(|x| (black_box(x), 1)));
                        right_input.extend(right_data.into_iter().map(|x| (black_box(x), 1)));
                    });
                });
            });
        });
    }
    group.finish();
}

fn bench_reduce_operation(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_reduce");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).map(|i| (i % 10, i)).collect();
                    
                    worker.dataflow::<(), _, _>(|scope| {
                        let (input, collection) = scope.new_collection();
                        
                        collection
                            .reduce(|_key, input, output| {
                                let sum: usize = input.iter().map(|(val, _)| *val).sum();
                                output.push((sum, 1));
                            })
                            .inspect(|_| {});
                        
                        input.extend(data.into_iter().map(|x| (black_box(x), 1)));
                    });
                });
            });
        });
    }
    group.finish();
}

fn bench_map_reduce_pattern(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_map_reduce");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).collect();
                    
                    worker.dataflow::<(), _, _>(|scope| {
                        let (input, collection) = scope.new_collection();
                        
                        collection
                            .map(|(val,)| (val % 10, val))
                            .reduce(|_key, input, output| {
                                let sum: usize = input.iter().map(|(val, _)| *val).sum();
                                output.push((sum, 1));
                            })
                            .inspect(|_| {});
                        
                        input.extend(data.into_iter().map(|x| ((black_box(x),), 1)));
                    });
                });
            });
        });
    }
    group.finish();
}

criterion_group!(
    benches,
    bench_count_operation,
    bench_join_operation,
    bench_reduce_operation,
    bench_map_reduce_pattern
);
criterion_main!(benches);
