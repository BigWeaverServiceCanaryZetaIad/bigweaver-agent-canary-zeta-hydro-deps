use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::Count;

fn count_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/count");
    
    for size in [1000, 10000, 100000].iter() {
        group.bench_with_input(BenchmarkId::new("count_basic", size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).count();
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
    
    for distinct_keys in [10, 100, 1000].iter() {
        group.bench_with_input(BenchmarkId::new("count_distinct_keys", distinct_keys), distinct_keys, |b, &distinct_keys| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        input.to_collection(scope).count();
                    });
                    
                    for i in 0..10000 {
                        input.insert(i % distinct_keys);
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

criterion_group!(benches, count_benchmarks);
criterion_main!(benches);
