// Fan-in benchmark for differential dataflow
// Tests merging multiple collections into one

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Concat;

fn fan_in_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_fan_in");
    
    for branches in [2, 4, 8, 16] {
        group.bench_with_input(BenchmarkId::from_parameter(branches), &branches, |b, &branches| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut count = 0;
                    let (inputs, probe) = worker.dataflow(|scope| {
                        let inputs: Vec<_> = (0..branches)
                            .map(|_| scope.new_collection::<u64>())
                            .collect();
                        
                        let mut combined = inputs[0].1.clone();
                        for (_, collection) in inputs.iter().skip(1) {
                            combined = combined.concat(collection);
                        }
                        
                        let result = combined.inspect(move |_| count += 1);
                        
                        (inputs.into_iter().map(|(h, _)| h).collect::<Vec<_>>(), result.probe())
                    });
                    
                    for (i, mut input) in inputs.into_iter().enumerate() {
                        for j in (i * 1000)..((i + 1) * 1000) {
                            input.insert(j as u64);
                        }
                        input.advance_to(1);
                        input.flush();
                    }
                    
                    worker.step_while(|| probe.less_than(&1));
                    black_box(count);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, fan_in_benchmark);
criterion_main!(benches);
