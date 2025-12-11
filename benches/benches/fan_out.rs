use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Map, ToStream};

const NUM_OPS: usize = 10;
const NUM_INTS: usize = 10_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let stream = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    stream
                        .map(|x| x)
                        .inspect(|i| {
                            black_box(i);
                        });
                }
            });
        })
    });
}

criterion_group!(fan_out_dataflow, benchmark_timely,);
criterion_main!(fan_out_dataflow);
