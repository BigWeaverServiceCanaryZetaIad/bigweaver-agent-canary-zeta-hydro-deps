// Benchmark for testing timely dataflow reachability computation
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Inspect, Probe};
use timely::dataflow::InputHandle;

fn reachability_benchmark(c: &mut Criterion) {
    c.bench_function("timely_reachability_1000", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                let mut input = InputHandle::new();
                let probe = worker.dataflow(|scope| {
                    let stream = input.to_stream(scope);
                    stream
                        .inspect(|x| {
                            black_box(x);
                        })
                        .probe()
                });
                
                for i in 0..1000 {
                    input.send(i);
                    input.advance_to(i + 1);
                    worker.step_while(|| probe.less_than(input.time()));
                }
            });
        })
    });
}

criterion_group!(benches, reachability_benchmark);
criterion_main!(benches);
