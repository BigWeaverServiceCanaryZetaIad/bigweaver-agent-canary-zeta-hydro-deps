use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 10;
const NUM_INTS: usize = 10_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut streams = Vec::new();
                for _ in 0..NUM_OPS {
                    streams.push((0..NUM_INTS).to_stream(scope));
                }
                scope
                    .concatenate(streams)
                    .inspect(|i| {
                        black_box(i);
                    });
            });
        })
    });
}

criterion_group!(fan_in_dataflow, benchmark_timely,);
criterion_main!(fan_in_dataflow);
