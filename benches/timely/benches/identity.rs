// Identity benchmark for timely dataflow
// Tests the overhead of passing data through the dataflow graph

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Inspect, ToStream};

fn identity_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_identity");
    
    for size in [100, 1_000, 10_000, 100_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut count = 0;
                    worker.dataflow(|scope| {
                        (0..size)
                            .to_stream(scope)
                            .inspect(move |_| count += 1);
                    });
                    black_box(count);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, identity_benchmark);
criterion_main!(benches);
