use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const BRANCH_FACTOR: usize = 2;
const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    let mut ops = Vec::new();

                    for i in 0..BRANCH_FACTOR {
                        ops.push(op.filter(move |x| x % BRANCH_FACTOR == i))
                    }

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
    fork_join_benches,
    benchmark_timely,
);
criterion_main!(fork_join_benches);
