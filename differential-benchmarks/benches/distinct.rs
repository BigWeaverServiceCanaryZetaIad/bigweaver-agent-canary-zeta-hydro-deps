use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::Threshold;

fn distinct_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/distinct");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("distinct_basic", size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).distinct();
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
    
    for duplicate_factor in [1, 10, 100].iter() {
        group.bench_with_input(BenchmarkId::new("distinct_with_duplicates", duplicate_factor), duplicate_factor, |b, &duplicate_factor| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).distinct();
                    });
                    
                    for i in 0..1000 {
                        for _ in 0..duplicate_factor {
                            input.insert(i % 100);
                        }
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

criterion_group!(benches, distinct_benchmarks);
criterion_main!(benches);
