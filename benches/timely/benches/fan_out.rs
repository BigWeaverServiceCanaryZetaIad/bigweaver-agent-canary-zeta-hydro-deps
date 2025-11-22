// Fan-out benchmark for timely dataflow
// Tests splitting one stream into multiple branches

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Inspect, ToStream};

fn fan_out_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_fan_out");
    
    for branches in [2, 4, 8, 16] {
        group.bench_with_input(BenchmarkId::from_parameter(branches), &branches, |b, &branches| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut counts = vec![0; branches];
                    worker.dataflow(|scope| {
                        let stream = (0..10000).to_stream(scope);
                        
                        for i in 0..branches {
                            let mut local_count = 0;
                            stream.inspect(move |_| local_count += 1);
                            counts[i] = local_count;
                        }
                    });
                    black_box(counts);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, fan_out_benchmark);
criterion_main!(benches);
