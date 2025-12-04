// Benchmark for testing differential dataflow operations
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Join;
use timely::dataflow::operators::Probe;

fn differential_join_benchmark(c: &mut Criterion) {
    c.bench_function("differential_join_1000", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                worker.dataflow::<usize, _, _>(|scope| {
                    let (mut input1, data1) = scope.new_collection();
                    let (mut input2, data2) = scope.new_collection();
                    
                    let probe = data1
                        .join(&data2)
                        .inspect(|x| {
                            black_box(x);
                        })
                        .probe();
                    
                    for i in 0..1000 {
                        input1.insert((i, i * 2));
                        input2.insert((i, i * 3));
                        input1.advance_to(i + 1);
                        input2.advance_to(i + 1);
                        input1.flush();
                        input2.flush();
                        worker.step_while(|| probe.less_than(&(i + 1)));
                    }
                });
            });
        })
    });
}

criterion_group!(benches, differential_join_benchmark);
criterion_main!(benches);
