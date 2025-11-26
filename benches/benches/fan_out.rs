use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let stream = (0..NUM_INTS).to_stream(scope);

                for _ in 0..NUM_OPS {
                    stream.map(|x| {
                        black_box(x);
                    });
                }
            });
        })
    });
}

criterion_group!(fan_out_timely, benchmark_timely);
criterion_main!(fan_out_timely);
