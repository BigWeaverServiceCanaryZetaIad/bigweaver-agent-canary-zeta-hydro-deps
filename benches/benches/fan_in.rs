use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn make_ints(i: usize) -> impl Iterator<Item = usize> {
    (i * NUM_INTS)..((i + 1) * NUM_INTS)
}

criterion_group!(
    fan_in_dataflow,
    benchmark_timely,
    benchmark_iters,
    benchmark_for_loops,
);

criterion_main!(fan_in_dataflow);
