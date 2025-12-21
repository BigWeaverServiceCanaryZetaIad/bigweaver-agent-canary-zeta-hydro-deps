use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_ROWS: usize = 100_000;
const STARTING_STRING: &str = "foobar";

criterion_group!(
    upcase_dataflow,
    benchmark_timely,
    benchmark_timely,
    benchmark_timely,
    benchmark_raw_copy,
    benchmark_raw_copy,
    benchmark_raw_copy,
    benchmark_iter,
    benchmark_iter,
    benchmark_iter,
);
criterion_main!(upcase_dataflow);