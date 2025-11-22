use criterion::{Criterion, black_box, criterion_group, criterion_main};
use rand::prelude::*;
use rand_distr::Standard;
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    let data: Vec<i64> = {
        let mut rng = StdRng::seed_from_u64(0xDEADBEEF);
        rng.sample_iter(Standard).take(NUM_INTS).collect()
    };

    c.bench_function("arithmetic/timely", |b| {
        b.iter(|| {
            let data = data.clone();
            timely::example(move |scope| {
                data.to_stream(scope)
                    .map(|x| x * 7 + x / 13 - 453)
                    .map(|x| -x * 2)
                    .inspect(|x| {
                        black_box(x);
                    });
            });
        });
    });
}

criterion_group!(
    arithmetic_dataflow,
    benchmark_timely,
);
criterion_main!(arithmetic_dataflow);
