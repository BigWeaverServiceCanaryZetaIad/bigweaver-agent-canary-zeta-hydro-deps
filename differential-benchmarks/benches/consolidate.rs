use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::Consolidate;

fn consolidate_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/consolidate");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("consolidate_basic", size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).consolidate();
                    });
                    
                    for i in 0..size {
                        input.insert(i % 100);
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    worker.step_while(|| worker.pending_work());
                });
            });
        });
    }
    
    for updates in [1, 10, 100].iter() {
        group.bench_with_input(BenchmarkId::new("consolidate_with_updates", updates), updates, |b, &updates| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).consolidate();
                    });
                    
                    for i in 0..1000 {
                        for _ in 0..updates {
                            input.insert(i % 100);
                            input.remove(i % 100);
                        }
                        input.insert(i % 100);
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

criterion_group!(benches, consolidate_benchmarks);
criterion_main!(benches);
