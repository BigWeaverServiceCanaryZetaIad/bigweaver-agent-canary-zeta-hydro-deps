use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let stream = (0..NUM_INTS).to_stream(scope);

                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });

                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });

                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });

                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
                stream.map(|x| x).inspect(|x| { black_box(x); });
            });
        })
    });
}

fn benchmark_sol(c: &mut Criterion) {
    c.bench_function("fan_out/sol", |b| {
        b.iter(|| {
            for x in 0..NUM_INTS {
                for _ in 0..NUM_OPS {
                    black_box(x);
                }
            }
        });
    });
}

criterion_group!(
    fan_out_dataflow,
    benchmark_timely,
    benchmark_sol,
);
criterion_main!(fan_out_dataflow);
