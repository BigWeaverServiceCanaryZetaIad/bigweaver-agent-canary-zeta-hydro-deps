
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Concat, Map, ToStream};

const NUM_INTS: usize = 1_000_000;

fn benchmark_timely_zip(c: &mut Criterion) {
    c.bench_function("zip/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let lhs = (0..NUM_INTS).map(|x| (x, x)).to_stream(scope);
                let rhs = (0..NUM_INTS).map(|x| (x, x + 1)).to_stream(scope);

                // Simple implementation using concat and map
                // This is a basic benchmark placeholder
                lhs.concat(&rhs)
                    .map(|(k, v)| {
                        black_box((k, v));
                    });
            });
        })
    });
}

fn benchmark_sol(c: &mut Criterion) {
    c.bench_function("zip/baseline", |b| {
        b.iter(|| {
            let iter_a = (0..NUM_INTS).map(|x| (x, x));
            let iter_b = (0..NUM_INTS).map(|x| (x, x + 1));

            for (a, b) in iter_a.zip(iter_b) {
                black_box((a, b));
            }
        });
    });
}

criterion_group!(
    zip_dataflow,
    benchmark_timely_zip,
    benchmark_sol,
);
criterion_main!(zip_dataflow);
