use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Inspect, ToStream};

fn simple_dataflow_benchmark(c: &mut Criterion) {
    c.bench_function("simple_timely_dataflow", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                worker.dataflow::<(), _, _>(|scope| {
                    (0..black_box(100))
                        .to_stream(scope)
                        .inspect(|_x| {});
                });
            });
        });
    });
}

criterion_group!(benches, simple_dataflow_benchmark);
criterion_main!(benches);
