use criterion::{criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Map, Probe};
use timely::dataflow::InputHandle;
use differential_dataflow::input::Input;
use differential_dataflow::operators::Reduce;

/// Benchmark for arithmetic operations in dataflow
fn arithmetic_benchmark(c: &mut Criterion) {
    c.bench_function("arithmetic_chain", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut input = InputHandle::new();
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                worker.dataflow(|scope| {
                    input
                        .to_stream(scope)
                        .map(|x: i32| x + 10)
                        .map(|x| x * 2)
                        .map(|x| x - 5)
                        .map(|x| x / 2)
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
    
    c.bench_function("differential_sum", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let mut probe = timely::dataflow::ProbeHandle::new();
                
                let mut input = worker.dataflow(|scope| {
                    let (input, data) = scope.new_collection();
                    
                    data.map(|(key, val)| (key, val))
                        .reduce(|_key, input, output| {
                            let sum: i32 = input.iter().map(|(val, _)| *val).sum();
                            output.push((sum, 1));
                        })
                        .probe_with(&mut probe);
                    
                    input
                });
                
                for i in 0..100 {
                    input.insert((i % 10, i));
                }
                input.advance_to(1);
                input.flush();
                
                worker.step_while(|| probe.less_than(&1));
            });
        });
    });
}

criterion_group!(benches, arithmetic_benchmark);
criterion_main!(benches);
