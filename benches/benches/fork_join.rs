use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 100_000;
const BRANCH_FACTOR: usize = 2;

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

fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("fork_join/raw", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();

            for _ in 0..NUM_OPS {
                let mut outputs: Vec<Vec<_>> = (0..BRANCH_FACTOR).map(|_| Vec::new()).collect();

                for elt in data.drain(..) {
                    outputs[elt % BRANCH_FACTOR].push(elt);
                }

                for output in outputs.drain(..) {
                    data.extend(output.into_iter());
                }
            }

            for elt in data {
                black_box(elt);
            }
        })
    });
}

criterion_group!(
    fork_join_dataflow,
    benchmark_timely,
    benchmark_raw,
);
criterion_main!(fork_join_dataflow);
