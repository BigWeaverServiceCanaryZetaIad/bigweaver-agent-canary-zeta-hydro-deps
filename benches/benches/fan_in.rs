use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn make_ints(i: usize) -> impl Iterator<Item = usize> {
    (i * NUM_INTS)..((i + 1) * NUM_INTS)
}

fn benchmark_timely(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                vec![
                    make_ints(0).to_stream(scope),
                    make_ints(1).to_stream(scope),
                    make_ints(2).to_stream(scope),
                    make_ints(3).to_stream(scope),
                    make_ints(4).to_stream(scope),
                    make_ints(5).to_stream(scope),
                    make_ints(6).to_stream(scope),
                    make_ints(7).to_stream(scope),
                    make_ints(8).to_stream(scope),
                    make_ints(9).to_stream(scope),
                    make_ints(10).to_stream(scope),
                    make_ints(11).to_stream(scope),
                    make_ints(12).to_stream(scope),
                    make_ints(13).to_stream(scope),
                    make_ints(14).to_stream(scope),
                    make_ints(15).to_stream(scope),
                    make_ints(16).to_stream(scope),
                    make_ints(17).to_stream(scope),
                    make_ints(18).to_stream(scope),
                    make_ints(19).to_stream(scope),
                ]
                .concatenate(scope)
                .inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}

fn benchmark_iters(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_in/iters", |b| {
        b.iter(|| {
            for elt in make_ints(0)
                .chain(make_ints(1))
                .chain(make_ints(2))
                .chain(make_ints(3))
                .chain(make_ints(4))
                .chain(make_ints(5))
                .chain(make_ints(6))
                .chain(make_ints(7))
                .chain(make_ints(8))
                .chain(make_ints(9))
                .chain(make_ints(10))
                .chain(make_ints(11))
                .chain(make_ints(12))
                .chain(make_ints(13))
                .chain(make_ints(14))
                .chain(make_ints(15))
                .chain(make_ints(16))
                .chain(make_ints(17))
                .chain(make_ints(18))
                .chain(make_ints(19))
            {
                black_box(elt);
            }
        })
    });
}

fn benchmark_for_loops(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_in/for_loops", |b| {
        b.iter(|| {
            for elt in make_ints(0) { black_box(elt); } for elt in make_ints(1) { black_box(elt); } for elt in make_ints(2) { black_box(elt); } for elt in make_ints(3) { black_box(elt); } for elt in make_ints(4) { black_box(elt); } for elt in make_ints(5) { black_box(elt); } for elt in make_ints(6) { black_box(elt); } for elt in make_ints(7) { black_box(elt); } for elt in make_ints(8) { black_box(elt); } for elt in make_ints(9) { black_box(elt); }
            for elt in make_ints(10) { black_box(elt); } for elt in make_ints(11) { black_box(elt); } for elt in make_ints(12) { black_box(elt); } for elt in make_ints(13) { black_box(elt); } for elt in make_ints(14) { black_box(elt); } for elt in make_ints(15) { black_box(elt); } for elt in make_ints(16) { black_box(elt); } for elt in make_ints(17) { black_box(elt); } for elt in make_ints(18) { black_box(elt); } for elt in make_ints(19) { black_box(elt); }
        })
    });
}

criterion_group!(
    fan_in_dataflow,
    benchmark_timely,
    benchmark_iters,
    benchmark_for_loops,
);
criterion_main!(fan_in_dataflow);
