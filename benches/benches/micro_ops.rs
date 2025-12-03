/// Micro-operation benchmarks for timely and differential-dataflow
/// 
/// This benchmark suite provides performance comparisons for basic
/// dataflow operations including map, filter, and aggregation primitives.

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::operators::{Inspect, ToStream};
use timely::dataflow::operators::{Map, Filter};

fn bench_timely_map(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_map");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).collect();
                    worker.dataflow::<(), _, _>(|scope| {
                        data.to_stream(scope)
                            .map(|x| black_box(x * 2))
                            .inspect(|_| {});
                    });
                });
            });
        });
    }
    group.finish();
}

fn bench_timely_filter(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_filter");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).collect();
                    worker.dataflow::<(), _, _>(|scope| {
                        data.to_stream(scope)
                            .filter(|x| black_box(*x % 2 == 0))
                            .inspect(|_| {});
                    });
                });
            });
        });
    }
    group.finish();
}

fn bench_timely_map_filter(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_map_filter");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let data: Vec<_> = (0..size).collect();
                    worker.dataflow::<(), _, _>(|scope| {
                        data.to_stream(scope)
                            .map(|x| black_box(x * 2))
                            .filter(|x| black_box(*x % 4 == 0))
                            .inspect(|_| {});
                    });
                });
            });
        });
    }
    group.finish();
}

criterion_group!(
    benches,
    bench_timely_map,
    bench_timely_filter,
    bench_timely_map_filter
);
criterion_main!(benches);
