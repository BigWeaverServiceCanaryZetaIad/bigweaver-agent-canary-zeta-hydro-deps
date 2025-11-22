use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Inspect, Join, Map, ToStream};

const NUM_INTS: usize = 100_000;

fn benchmark_timely<L, R>(c: &mut Criterion)
where
    L: Fn(usize) -> usize + 'static,
    R: Fn(usize) -> usize + 'static,
{
    c.bench_function("join/timely", move |b| {
        b.iter(|| {
            let lhs_fn = |i| i;
            let rhs_fn = |i| i;

            timely::example(|scope| {
                let lhs = (0..NUM_INTS).to_stream(scope).map(move |x| (lhs_fn(x), x));
                let rhs = (0..NUM_INTS)
                    .to_stream(scope)
                    .map(move |x| (rhs_fn(x), x + NUM_INTS));

                lhs.join(&rhs).inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}

criterion_group!(
    join_dataflow,
    benchmark_timely::<fn(usize) -> usize, fn(usize) -> usize>,
);
criterion_main!(join_dataflow);
