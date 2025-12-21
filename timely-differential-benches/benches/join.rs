use criterion::{Criterion, black_box, criterion_group, criterion_main};
use std::collections::HashMap;
use timely::dataflow::channels::pact::Pipeline;
use timely::dataflow::operators::{Operator, ToStream};

const NUM_INTS: usize = 100_000;

criterion_group!(
    fan_in_dataflow,
    benchmark_timely,
    benchmark_timely,
);
criterion_main!(fan_in_dataflow);