use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let source = (0..NUM_INTS).to_stream(scope);

                let _sinks: Vec<_> = (0..NUM_OPS)
                    .map(|_| source.clone().map(black_box))
                    .collect();
            });
        })
    });
}

criterion_group!(fan_out_dataflow, benchmark_timely);
criterion_main!(fan_out_dataflow);
