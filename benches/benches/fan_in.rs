use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concat, Inspect, ToStream};

const NUM_STREAMS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let streams: Vec<_> = (0..NUM_STREAMS)
                    .map(|_| (0..NUM_INTS).to_stream(scope))
                    .collect();

                let mut result = streams[0].clone();
                for stream in &streams[1..] {
                    result = result.concat(stream);
                }

                result.inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}

criterion_group!(
    fan_in_dataflow,
    benchmark_timely,
);
criterion_main!(fan_in_dataflow);
