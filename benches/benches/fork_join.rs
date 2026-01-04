use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("fork_join/raw", |b| {
        b.iter(|| {
            let mut results = Vec::new();
            for i in 0..NUM_INTS {
                let mut value = i;
                for _ in 0..NUM_OPS {
                    if value % 2 == 0 {
                        results.push(value);
                    }
                    if value % 2 == 1 {
                        results.push(value);
                    }
                }
            }
            for x in results {
                black_box(x);
            }
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    const_assert!(NUM_OPS == 20); // This benchmark is hardcoded for 20 ops, so assert that NUM_OPS is 20.
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut stream = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    let left = stream.filter(|x| x % 2 == 0);
                    let right = stream.filter(|x| x % 2 == 1);
                    stream = scope.concatenate(vec![left, right]);
                }
                stream.inspect(|x| {
                    black_box(x);
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
