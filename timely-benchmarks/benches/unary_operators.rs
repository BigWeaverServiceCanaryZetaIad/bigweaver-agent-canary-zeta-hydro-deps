use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main, black_box};
use timely::dataflow::operators::{ToStream, Map, Filter, Inspect};

fn unary_operators_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/unary_operators");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("map", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .map(|x| black_box(x * 2))
                        .inspect(|_| {});
                });
            });
        });
    }
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("filter", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .filter(|x| black_box(x % 2 == 0))
                        .inspect(|_| {});
                });
            });
        });
    }
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("flat_map", size), size, |b, &size| {
            b.iter(|| {
                timely::example(|scope| {
                    (0..size).to_stream(scope)
                        .flat_map(|x| vec![x, x * 2])
                        .inspect(|_| {});
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, unary_operators_benchmarks);
criterion_main!(benches);
