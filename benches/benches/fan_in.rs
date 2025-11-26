use criterion::{Criterion, criterion_group, criterion_main};
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
                let streams = (0..NUM_OPS)
                    .map(|i| make_ints(i).to_stream(scope))
                    .collect::<Vec<_>>();

                scope
                    .concatenate(streams)
                    .inspect(|_| {});
            });
        })
    });
}

criterion_group!(fan_in_timely, benchmark_timely);
criterion_main!(fan_in_timely);
