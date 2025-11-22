// Micro-operations benchmark for differential dataflow
// Tests various small operations like filter, map, etc.

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::{Filter, Map};

fn micro_ops_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential_micro_ops");
    
    // Filter benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("filter", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut count = 0;
                        let (mut input, probe) = worker.dataflow(|scope| {
                            let (input, collection) = scope.new_collection::<u64>();
                            
                            let result = collection
                                .filter(|x| x % 2 == 0)
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
            },
        );
    }
    
    // Map benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("map", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut sum = 0u64;
                        let (mut input, probe) = worker.dataflow(|scope| {
                            let (input, collection) = scope.new_collection::<u64>();
                            
                            let result = collection
                                .map(|x| x * 2)
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
            },
        );
    }
    
    // Chain of operations benchmark
    for size in [1_000, 10_000, 100_000] {
        group.bench_with_input(
            BenchmarkId::new("chain", size),
            &size,
            |b, &size| {
                b.iter(|| {
                    timely::execute_directly(move |worker| {
                        let mut sum = 0u64;
                        let (mut input, probe) = worker.dataflow(|scope| {
                            let (input, collection) = scope.new_collection::<u64>();
                            
                            let result = collection
                                .filter(|x| x % 2 == 0)
                                .map(|x| x * 2)
                                .filter(|x| x % 3 == 0)
                                .map(|x| x + 1)
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
            },
        );
    }
    
    group.finish();
}

criterion_group!(benches, micro_ops_benchmark);
criterion_main!(benches);
