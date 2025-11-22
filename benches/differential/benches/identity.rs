// Identity benchmark for differential dataflow
// Tests the overhead of passing data through the dataflow graph

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;

fn identity_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_identity");
    
    for size in [100, 1_000, 10_000, 100_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut count = 0;
                    let (mut input, probe) = worker.dataflow(|scope| {
                        let (input, collection) = scope.new_collection::<u64>();
                        
                        let result = collection
                            .inspect(move |_| count += 1);
                        
                        (input, result.probe())
                    });
                    
                    for i in 0..size {
                        input.insert(i);
                    }
                    input.advance_to(1);
                    input.flush();
                    worker.step_while(|| probe.less_than(input.time()));
                    
                    black_box(count);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, identity_benchmark);
criterion_main!(benches);
