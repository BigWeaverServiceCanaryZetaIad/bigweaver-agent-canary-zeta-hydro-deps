use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Map, Filter, Inspect};

fn dataflow_construction_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/dataflow_construction");
    
    group.bench_function("simple_pipeline", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..1000).to_stream(scope)
                    .map(|x| x * 2)
                    .filter(|x| x % 2 == 0)
                    .inspect(|_| {});
            });
        });
    });
    
    for depth in [5, 10, 20].iter() {
        group.bench_with_input(BenchmarkId::new("deep_pipeline", depth), depth, |b, &depth| {
            b.iter(|| {
                timely::example(|scope| {
                    let mut stream = (0..1000).to_stream(scope);
                    for _ in 0..depth {
                        stream = stream.map(|x| x + 1);
                    }
                    stream.inspect(|_| {});
                });
            });
        });
    }
    
    for width in [5, 10, 20].iter() {
        group.bench_with_input(BenchmarkId::new("wide_pipeline", width), width, |b, &width| {
            b.iter(|| {
                timely::example(|scope| {
                    for _ in 0..width {
                        (0..1000).to_stream(scope)
                            .map(|x| x * 2)
                            .inspect(|_| {});
                    }
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, dataflow_construction_benchmarks);
criterion_main!(benches);
