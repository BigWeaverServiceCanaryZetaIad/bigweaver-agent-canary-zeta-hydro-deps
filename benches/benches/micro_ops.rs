use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};
use timely::dataflow::operators::{Map, Filter, Probe};
use timely::dataflow::InputHandle;

/// Benchmark for basic dataflow operations
fn micro_ops_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("micro_ops");
    
    // Map operation benchmark
    group.bench_function("map", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut input = InputHandle::new();
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                worker.dataflow(|scope| {
                    input
                        .to_stream(scope)
                        .map(|x: i32| x * 2)
                        .probe_with(&mut probe);
                });
                
                for i in 0..1000 {
                    input.send(i);
                }
                input.advance_to(1);
                
                worker.step_while(|| probe.less_than(input.time()));
            });
        });
    });
    
    // Filter operation benchmark
    group.bench_function("filter", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut input = InputHandle::new();
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                worker.dataflow(|scope| {
                    input
                        .to_stream(scope)
                        .filter(|x: &i32| x % 2 == 0)
                        .probe_with(&mut probe);
                });
                
                for i in 0..1000 {
                    input.send(i);
                }
                input.advance_to(1);
                
                worker.step_while(|| probe.less_than(input.time()));
            });
        });
    });
    
    group.finish();
}

criterion_group!(benches, micro_ops_benchmark);
criterion_main!(benches);
