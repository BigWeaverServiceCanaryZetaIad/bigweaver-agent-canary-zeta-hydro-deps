use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000;

fn make_ints(n: usize) -> impl Iterator<Item = usize> {
    (n * NUM_INTS..(n + 1) * NUM_INTS)
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

criterion_group!(
    fan_in_benches,
    benchmark_timely,
);
criterion_main!(fan_in_benches);
