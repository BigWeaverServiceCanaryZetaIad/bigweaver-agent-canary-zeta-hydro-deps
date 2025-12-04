use criterion::{criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{ToStream, Map, Probe};
use timely::dataflow::InputHandle;

/// Benchmark for fan-out operations
fn fan_out_benchmark(c: &mut Criterion) {
    c.bench_function("fan_out_4x", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut input = InputHandle::new();
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                worker.dataflow(|scope| {
                    let stream = input.to_stream(scope);
                    
                    // Create 4 consumers
                    stream.map(|x: i32| x + 1).probe_with(&mut probe);
                    stream.map(|x: i32| x + 2).probe_with(&mut probe);
                    stream.map(|x: i32| x + 3).probe_with(&mut probe);
                    stream.map(|x: i32| x + 4).probe_with(&mut probe);
                });
                
                for i in 0..1000 {
                    input.send(i);
                }
                input.advance_to(1);
                
                worker.step_while(|| probe.less_than(input.time()));
            });
        });
    });
}

criterion_group!(benches, fan_out_benchmark);
criterion_main!(benches);
