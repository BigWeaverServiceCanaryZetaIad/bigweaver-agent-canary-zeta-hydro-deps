// Arithmetic benchmark for timely dataflow
// Tests basic arithmetic operations on streams

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Inspect, Map, ToStream};

fn arithmetic_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_arithmetic");
    
    for size in [100, 1_000, 10_000, 100_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut sum = 0u64;
                    worker.dataflow(|scope| {
                        (0..size)
                            .to_stream(scope)
                            .map(|x| x * 2 + 1)
                            .map(|x| x * 3)
                            .map(|x| x / 2)
                            .inspect(move |x| sum += x);
                    });
                    black_box(sum);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, arithmetic_benchmark);
criterion_main!(benches);
