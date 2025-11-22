// Fan-in benchmark for timely dataflow
// Tests merging multiple streams into one

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use timely::dataflow::operators::{Concat, Inspect, ToStream};

fn fan_in_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely_fan_in");
    
    for branches in [2, 4, 8, 16] {
        group.bench_with_input(BenchmarkId::from_parameter(branches), &branches, |b, &branches| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut count = 0;
                    worker.dataflow(|scope| {
                        let streams: Vec<_> = (0..branches)
                            .map(|i| (i * 1000..(i + 1) * 1000).to_stream(scope))
                            .collect();
                        
                        let mut combined = streams[0].clone();
                        for stream in streams.iter().skip(1) {
                            combined = combined.concat(stream);
                        }
                        
                        combined.inspect(move |_| count += 1);
                    });
                    black_box(count);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, fan_in_benchmark);
criterion_main!(benches);
