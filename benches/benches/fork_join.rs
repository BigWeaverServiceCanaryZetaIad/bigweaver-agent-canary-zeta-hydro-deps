use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 100_000;
const BRANCH_FACTOR: usize = 2;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut streams = vec![(0..NUM_INTS).to_stream(scope)];
                for _ in 0..NUM_OPS {
                    let mut new_streams = Vec::new();
                    for stream in streams.drain(..) {
                        for i in 0..BRANCH_FACTOR {
                            new_streams.push(stream.filter(move |x| x % BRANCH_FACTOR == i));
                        }
                    }
                    streams = vec![scope.concatenate(new_streams)];
                }

                streams.into_iter().next().unwrap().inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}

criterion_group!(fork_join_timely, benchmark_timely);
criterion_main!(fork_join_timely);
