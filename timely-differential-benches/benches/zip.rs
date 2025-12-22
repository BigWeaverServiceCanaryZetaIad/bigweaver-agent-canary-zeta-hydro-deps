use criterion::{black_box, criterion_group, criterion_main, Criterion};

const NUM_INTS: usize = 1_000_000;

fn benchmark_iter_zip(c: &mut Criterion) {
    c.bench_function("zip/iter", |b| {
        b.iter(|| {
            let iter_a = 0..NUM_INTS;
            let iter_b = 0..NUM_INTS;
            
            for pair in iter_a.zip(iter_b) {
                black_box(pair);
            }
        })
    });
}

criterion_group!(
    zip_dataflow,
    benchmark_iter_zip,
);
criterion_main!(zip_dataflow);
