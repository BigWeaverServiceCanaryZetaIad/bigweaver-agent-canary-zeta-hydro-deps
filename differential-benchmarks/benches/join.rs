use criterion::{BenchmarkId, Criterion, criterion_group, criterion_main};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::Join;

fn join_benchmarks(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/join");
    
    for size in [100, 1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::new("simple_join", size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input1 = InputSession::new();
                    let mut input2 = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        let collection1 = input1.to_collection(scope);
                        let collection2 = input2.to_collection(scope);
                        
                        collection1.join(&collection2);
                    });
                    
                    for i in 0..size {
                        input1.insert((i % 100, i));
                        input2.insert((i % 100, i * 2));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input1.flush();
                    input2.flush();
                    
                    worker.step_while(|| worker.pending_work());
                });
            });
        });
    }
    
    for selectivity in [1, 10, 50].iter() {
        group.bench_with_input(BenchmarkId::new("join_selectivity", selectivity), selectivity, |b, &selectivity| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input1 = InputSession::new();
                    let mut input2 = InputSession::new();
                    
                    worker.dataflow::<usize, _, _>(|scope| {
                        let collection1 = input1.to_collection(scope);
                        let collection2 = input2.to_collection(scope);
                        
                        collection1.join(&collection2);
                    });
                    
                    for i in 0..1000 {
                        input1.insert((i % selectivity, i));
                        input2.insert((i % selectivity, i * 2));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input1.flush();
                    input2.flush();
                    
                    worker.step_while(|| worker.pending_work());
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, join_benchmarks);
criterion_main!(benches);
