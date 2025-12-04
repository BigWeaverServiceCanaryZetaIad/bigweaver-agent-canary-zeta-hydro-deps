use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_OPS: usize = 10;
const NUM_INTS: usize = 10_000;

// Pipeline: pass through a Vec without allocating
fn benchmark_pipeline(c: &mut Criterion) {
    c.bench_function("arithmetic/pipeline", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();

            for _ in 0..NUM_OPS {
                data = data.into_iter().map(|x| x + 1).collect();
            }

            for elt in data {
                black_box(elt);
            }
        })
    });
}

// Raw copy: minimal overhead baseline
fn benchmark_raw_copy(c: &mut Criterion) {
    c.bench_function("arithmetic/raw", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();

            for _ in 0..NUM_OPS {
                for elt in &mut data {
                    *elt += 1;
                }
            }

            for elt in data {
                black_box(elt);
            }
        })
    });
}

// Iterator chain without intermediate collections
fn benchmark_iter(c: &mut Criterion) {
    c.bench_function("arithmetic/iter", |b| {
        b.iter(|| {
            let iter = 0..NUM_INTS;

            // Chain NUM_OPS map operations
            seq_macro::seq!(_ in 0..10 {
                let iter = iter.map(|x| x + 1);
            });

            for elt in iter {
                black_box(elt);
            }
        });
    });
}

// Iterator with final collect
fn benchmark_iter_collect(c: &mut Criterion) {
    c.bench_function("arithmetic/iter_collect", |b| {
        b.iter(|| {
            let iter = 0..NUM_INTS;

            seq_macro::seq!(_ in 0..10 {
                let iter = iter.map(|x| x + 1);
            });

            let data: Vec<_> = iter.collect();

            for elt in data {
                black_box(elt);
            }
        });
    });
}

// Timely Dataflow implementation
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
    identity_dataflow,
    benchmark_timely,
    benchmark_pipeline,
    benchmark_iter,
    benchmark_iter_collect,
    benchmark_raw_copy,
);
criterion_main!(identity_dataflow);
