use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let op = (0..NUM_INTS).to_stream(scope);
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
                op.inspect(|i| { black_box(i); });
            });
        })
    });
}

fn benchmark_for_loops(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_out/for_loops", |b| {
        b.iter(|| {
            for elt in 0..NUM_INTS {
                black_box(elt); black_box(elt); black_box(elt); black_box(elt); black_box(elt);
                black_box(elt); black_box(elt); black_box(elt); black_box(elt); black_box(elt);
                black_box(elt); black_box(elt); black_box(elt); black_box(elt); black_box(elt);
                black_box(elt); black_box(elt); black_box(elt); black_box(elt); black_box(elt);
            }
        })
    });
}

criterion_group!(
    fan_out_dataflow,
    benchmark_timely,
    benchmark_for_loops,
);
criterion_main!(fan_out_dataflow);
