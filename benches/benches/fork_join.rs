use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 100_000;

fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("fork_join/raw", |b| {
        b.iter(|| {
            let mut stream1: Vec<_> = (0..NUM_INTS).filter(|x| x % 2 == 0).collect();
            let mut stream2: Vec<_> = (0..NUM_INTS).filter(|x| x % 2 == 1).collect();

            for _ in 0..NUM_OPS {
                let combined: Vec<_> = stream1.into_iter().chain(stream2).collect();
                stream1 = combined.iter().copied().filter(|x| x % 2 == 0).collect();
                stream2 = combined.into_iter().filter(|x| x % 2 == 1).collect();
            }

            for x in stream1.into_iter().chain(stream2) {
                black_box(x);
            }
        })
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);

                for _ in 0..NUM_OPS {
                    let ops: Vec<_> = (0..2)
                        .map(|i| op.clone().filter(move |x| x % 2 == i))
                        .collect();

                    op = scope.concatenate(ops);
                }

                op.inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}

criterion_group!(
    fork_join_dataflow,
    benchmark_timely,
    benchmark_raw,
);
criterion_main!(fork_join_dataflow);
