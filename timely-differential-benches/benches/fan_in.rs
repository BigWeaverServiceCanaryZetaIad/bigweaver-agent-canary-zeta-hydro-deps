
use criterion::{black_box, criterion_group, criterion_main, Criterion};

use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn make_ints(i: usize) -> impl Iterator<Item = usize> {
    (i * NUM_INTS)..((i + 1) * NUM_INTS)
}



fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let sources: Vec<_> = (0..NUM_OPS)
                    .map(|i| make_ints(i).to_stream(scope))
                    .collect();

                let merged = scope.concatenate(sources);

                merged.inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}


fn benchmark_iters(c: &mut Criterion) {
    c.bench_function("fan_in/iters", |b| {
        b.iter(|| {
            (0..NUM_OPS).map(make_ints).flatten().for_each(|x| {
                black_box(x);
            });
        });
    });
}

fn benchmark_for_loops(c: &mut Criterion) {
    c.bench_function("fan_in/loops", |b| {
        b.iter(|| {
            let iters: Vec<_> = (0..NUM_OPS).map(make_ints).collect();
            for iter in iters {
                for x in iter {
                    black_box(x);
                }
            }
        });
    });
}

criterion_group!(
    fan_in_dataflow,
    benchmark_timely,
    benchmark_iters,
    benchmark_for_loops,
);
criterion_main!(fan_in_dataflow);
