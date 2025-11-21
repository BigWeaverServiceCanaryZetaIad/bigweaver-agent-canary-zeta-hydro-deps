use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};

fn barrier_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/barrier");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("single_thread", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .inspect(|_| {});
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, barrier_benchmarks);
criterion_main!(benches);
