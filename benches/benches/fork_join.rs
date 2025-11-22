use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Concat, Inspect, Map, ToStream};

const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let base = (0..NUM_INTS).to_stream(scope);
                let branch_a = base.map(|x| x * 7);
                let branch_b = base.map(|x| -x);

                branch_a.concat(&branch_b).inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}

criterion_group!(
    fork_join_dataflow,
    benchmark_timely,
);
criterion_main!(fork_join_dataflow);
