use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main, black_box};
use timely::dataflow::operators::{ToStream, Exchange, Inspect};

fn exchange_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/exchange");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("round_robin", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .exchange(|x| black_box(*x as u64))
                        .inspect(|_| {});
                });
            });
        });
    }
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("hash_partition", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .exchange(|x| black_box((x % 10) as u64))
                        .inspect(|_| {});
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, exchange_benchmarks);
criterion_main!(benches);
