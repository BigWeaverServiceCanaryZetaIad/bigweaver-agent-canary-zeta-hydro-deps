use criterion::{criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{ToStream, Concat, Probe};
use timely::dataflow::InputHandle;

/// Benchmark for fan-in operations
fn fan_in_benchmark(c: &mut Criterion) {
    c.bench_function("fan_in_4x", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut input1 = InputHandle::new();
                let mut input2 = InputHandle::new();
                let mut input3 = InputHandle::new();
                let mut input4 = InputHandle::new();
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                worker.dataflow(|scope| {
                    let stream1 = input1.to_stream(scope);
                    let stream2 = input2.to_stream(scope);
                    let stream3 = input3.to_stream(scope);
                    let stream4 = input4.to_stream(scope);
                    
                    stream1
                        .concat(&stream2)
                        .concat(&stream3)
                        .concat(&stream4)
                        .probe_with(&mut probe);
                });
                
                for i in 0..250 {
                    input1.send(i);
                    input2.send(i + 1000);
                    input3.send(i + 2000);
                    input4.send(i + 3000);
                }
                
                input1.advance_to(1);
                input2.advance_to(1);
                input3.advance_to(1);
                input4.advance_to(1);
                
                worker.step_while(|| probe.less_than(&1));
            });
        });
    });
}

criterion_group!(benches, fan_in_benchmark);
criterion_main!(benches);
