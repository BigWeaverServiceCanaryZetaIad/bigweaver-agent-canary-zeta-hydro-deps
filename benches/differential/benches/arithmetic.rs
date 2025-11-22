// Arithmetic benchmark for differential dataflow
// Tests basic arithmetic operations on collections

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Map;

fn arithmetic_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_arithmetic");
    
    for size in [100, 1_000, 10_000, 100_000] {
        group.bench_with_input(BenchmarkId::from_parameter(size), &size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut sum = 0u64;
                    let (mut input, probe) = worker.dataflow(|scope| {
                        let (input, collection) = scope.new_collection();
                        
                        let result = collection
                            .map(|x: u64| x * 2 + 1)
                            .map(|x| x * 3)
                            .map(|x| x / 2)
                            .inspect(move |x| sum += x.0);
                        
                        (input, result.probe())
                    });
                    
                    for i in 0..size {
                        input.insert(i);
                    }
                    input.advance_to(1);
                    input.flush();
                    worker.step_while(|| probe.less_than(input.time()));
                    
                    black_box(sum);
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, arithmetic_benchmark);
criterion_main!(benches);
