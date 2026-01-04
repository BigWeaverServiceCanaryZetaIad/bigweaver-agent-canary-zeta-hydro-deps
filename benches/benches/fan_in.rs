use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn make_ints(i: usize) -> impl Iterator<Item = usize> {
    (i * NUM_INTS)..((i + 1) * NUM_INTS)
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let streams = (0..NUM_OPS)
                    .map(|i| make_ints(i).to_stream(scope))
                    .collect::<Vec<_>>();

                scope
                    .concatenate(streams)
                    .inspect(|x| {
                        black_box(x);
                    });
            });
        });
    });
}

fn benchmark_iters(c: &mut Criterion) {
    c.bench_function("fan_in/iters", |b| {
        b.iter(|| {
            for i in (0..NUM_OPS).flat_map(make_ints) {
                black_box(i);
            }
        });
    });
}

fn benchmark_for_loops(c: &mut Criterion) {
    c.bench_function("fan_in/for_loops", |b| {
        b.iter(|| {
            for i in 0..NUM_OPS {
                for x in make_ints(i) {
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
