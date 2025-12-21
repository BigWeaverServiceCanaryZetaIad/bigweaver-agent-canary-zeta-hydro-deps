use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

/// Benchmark for timely-dataflow's arithmetic operations.
/// This benchmark applies a series of map operations (adding 1) to a stream of integers.
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("arithmetic/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    op = op.map(|x| x + 1)
                }

                op.inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}

criterion_group!(
    arithmetic_benches,
    benchmark_timely,
);
criterion_main!(arithmetic_benches);
