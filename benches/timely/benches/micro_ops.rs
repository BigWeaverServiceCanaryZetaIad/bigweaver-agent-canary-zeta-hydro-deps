// Micro-operations benchmark for timely dataflow
// Tests various small operations like filter, map, etc.

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Filter, Inspect, Map, ToStream};

fn micro_ops_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_micro_ops");
    
    // Filter benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("filter", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut count = 0;
                        worker.dataflow(|scope| {
                            (0..size)
                                .to_stream(scope)
                                .filter(|x| x % 2 == 0)
                                .inspect(move |_| count += 1);
                        });
                        black_box(count);
                    });
                });
            },
        );
    }
    
    // Map benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("map", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut sum = 0u64;
                        worker.dataflow(|scope| {
                            (0..size)
                                .to_stream(scope)
                                .map(|x| x * 2)
                                .inspect(move |x| sum += x);
                        });
                        black_box(sum);
                    });
                });
            },
        );
    }
    
    // Chain of operations benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("chain", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut sum = 0u64;
                        worker.dataflow(|scope| {
                            (0..size)
                                .to_stream(scope)
                                .filter(|x| x % 2 == 0)
                                .map(|x| x * 2)
                                .filter(|x| x % 3 == 0)
                                .map(|x| x + 1)
                                .inspect(move |x| sum += x);
                        });
                        black_box(sum);
                    });
                });
            },
        );
    }
    
    group.finish();
}

criterion_group!(benches, micro_ops_benchmark);
criterion_main!(benches);
