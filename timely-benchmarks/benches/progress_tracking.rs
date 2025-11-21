use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Map, Concat, Inspect};
use timely::dataflow::Scope;

fn progress_tracking_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/progress_tracking");
    
    group.bench_function("linear_chain", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..10000).to_stream(scope)
                    .map(|x| x * 2)
                    .map(|x| x + 1)
                    .map(|x| x / 2)
                    .inspect(|_| {});
            });
        });
    });
    
    for branches in [2, 4, 8].iter() {
        group.bench_with_input(BenchmarkId::new("branching", branches), branches, |b, &branches| {
            b.iter(|| {
                timely::example(|scope| {
                    let base = (0..1000).to_stream(scope);
                    let mut streams = vec![];
                    for i in 0..branches {
                        streams.push(base.map(move |x| x + i));
                    }
                    let mut result = streams[0].clone();
                    for stream in streams.into_iter().skip(1) {
                        result = result.concat(&stream);
                    }
                    result.inspect(|_| {});
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, progress_tracking_benchmarks);
criterion_main!(benches);
