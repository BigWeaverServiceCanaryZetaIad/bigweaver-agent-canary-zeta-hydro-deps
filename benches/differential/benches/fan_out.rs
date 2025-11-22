// Fan-out benchmark for differential dataflow
// Tests splitting one collection into multiple branches

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;

fn fan_out_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_fan_out");
    
    for branches in [2, 4, 8, 16] {
        group.bench_with_input(BenchmarkId::from_parameter(branches), &branches, |b, &branches| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut counts = vec![0; branches];
                    let (mut input, probe) = worker.dataflow(|scope| {
                        let (input, collection) = scope.new_collection::<u64>();
                        
                        for i in 0..branches {
                            let mut local_count = 0;
                            collection.inspect(move |_| local_count += 1);
                            counts[i] = local_count;
                        }
                        
                        (input, collection.probe())
                    });
                    
                    for i in 0..10000 {
                        input.insert(i);
                    }
                    input.advance_to(1);
                    input.flush();
                    worker.step_while(|| probe.less_than(input.time()));
                    
                    black_box(counts);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, fan_out_benchmark);
criterion_main!(benches);
