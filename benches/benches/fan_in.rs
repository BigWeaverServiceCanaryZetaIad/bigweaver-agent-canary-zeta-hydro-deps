use criterion::{black_box, criterion_group, criterion_main, Criterion};

/// Benchmark fan-in pattern using timely-dataflow
fn timely_fan_in(c: &mut Criterion) {
    c.bench_function("timely_fan_in", |b| {
        b.iter(|| {
            // TODO: Implement timely-dataflow fan-in benchmark
            // Multiple inputs converging to a single operator
            black_box(42)
        });
    });
}

/// Benchmark fan-in pattern using differential-dataflow
fn differential_fan_in(c: &mut Criterion) {
    c.bench_function("differential_fan_in", |b| {
        b.iter(|| {
            // TODO: Implement differential-dataflow fan-in benchmark
            // Multiple inputs converging to a single operator
            black_box(42)
        });
    });
}

criterion_group!(benches, timely_fan_in, differential_fan_in);
criterion_main!(benches);
