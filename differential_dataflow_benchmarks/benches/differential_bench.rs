use criterion::{black_box, criterion_group, criterion_main, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Count;

fn simple_differential_benchmark(c: &mut Criterion) {
    c.bench_function("simple_differential_dataflow", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                worker.dataflow::<(), _, _>(|scope| {
                    let (mut input, probe) = scope.new_collection();
                    
                    input
                        .count()
                        .inspect(|_x| {})
                        .probe_with(&mut probe);

                    // Insert sample data
                    for i in 0..black_box(100) {
                        input.insert(i);
                    }
                    input.advance_to(1);
                    input.flush();
                });
            });
        });
    });
}

criterion_group!(benches, simple_differential_benchmark);
criterion_main!(benches);
