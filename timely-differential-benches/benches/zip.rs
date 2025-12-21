use criterion::{black_box, criterion_group, criterion_main, Criterion};

const NUM_INTS: usize = 1_000_000;

fn benchmark_iter_zip(c: &mut Criterion) {
    c.bench_function("zip/iter", |b| {
        b.iter(|| {
            (0..NUM_INTS)
                .map(|x| (x, x))
                .zip((0..NUM_INTS).map(|x| (x, x)))
                .for_each(|v| {
                    black_box(v);
                });
        })
    });
}

fn benchmark_for_loop_zip(c: &mut Criterion) {
    c.bench_function("zip/loop", |b| {
        b.iter(|| {
            let lhs: Vec<_> = (0..NUM_INTS).map(|x| (x, x)).collect();
            let rhs: Vec<_> = (0..NUM_INTS).map(|x| (x, x)).collect();
            for (l, r) in lhs.iter().zip(rhs.iter()) {
                black_box((l, r));
            }
        })
    });
}

criterion_group!(
    zip_dataflow,
    benchmark_iter_zip,
    benchmark_for_loop_zip,
);
criterion_main!(zip_dataflow);
