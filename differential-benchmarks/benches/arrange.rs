use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::arrange::ArrangeByKey;

fn arrange_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/arrange");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("arrange_by_key", size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope)
                            .arrange_by_key();
                    });
                    
                    for i in 0..size {
                        input.insert((i % 100, i));
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    worker.step_while(|| worker.pending_work());
                });
            });
        });
    }
    
    for key_count in [10, 100, 1000].iter() {
        group.bench_with_input(BenchmarkId::new("arrange_varying_keys", key_count), key_count, |b, &key_count| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope)
                            .arrange_by_key();
                    });
                    
                    for i in 0..10000 {
                        input.insert((i % key_count, i));
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    worker.step_while(|| worker.pending_work());
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, arrange_benchmarks);
criterion_main!(benches);
