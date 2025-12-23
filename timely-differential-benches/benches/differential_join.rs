use criterion::{black_box, criterion_group, criterion_main, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Join;
use std::collections::HashMap;

const NUM_ITEMS: usize = 50_000;

fn benchmark_differential_join(c: &mut Criterion) {
    c.bench_function("differential_join/differential", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input1, mut input2, probe) = worker.dataflow(|scope| {
                    let (input1, data1) = scope.new_collection();
                    let (input2, data2) = scope.new_collection();
                    let joined = data1.join(&data2);
                    (input1, input2, joined.probe())
                });

                // Insert data into first collection
                for i in 0..NUM_ITEMS {
                    input1.insert((i, format!("left_{}", i)));
                }
                
                // Insert data into second collection (50% overlap)
                for i in NUM_ITEMS / 2..NUM_ITEMS * 3 / 2 {
                    input2.insert((i, format!("right_{}", i)));
                }
                
                input1.advance_to(1);
                input2.advance_to(1);
                input1.flush();
                input2.flush();
                worker.step_while(|| probe.less_than(&input1.time()));

                black_box(());
            });
        })
    });
}

fn benchmark_baseline_join(c: &mut Criterion) {
    c.bench_function("differential_join/baseline", |b| {
        b.iter(|| {
            let mut left: HashMap<usize, Vec<String>> = HashMap::new();
            let mut right: HashMap<usize, Vec<String>> = HashMap::new();
            
            // Build left collection
            for i in 0..NUM_ITEMS {
                left.entry(i)
                    .or_insert_with(Vec::new)
                    .push(format!("left_{}", i));
            }
            
            // Build right collection
            for i in NUM_ITEMS / 2..NUM_ITEMS * 3 / 2 {
                right.entry(i)
                    .or_insert_with(Vec::new)
                    .push(format!("right_{}", i));
            }
            
            // Perform join
            for (key, left_vals) in &left {
                if let Some(right_vals) = right.get(key) {
                    for left_val in left_vals {
                        for right_val in right_vals {
                            black_box((key, left_val, right_val));
                        }
                    }
                }
            }
        })
    });
}

fn benchmark_differential_join_updates(c: &mut Criterion) {
    c.bench_function("differential_join/differential_updates", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input1, mut input2, probe) = worker.dataflow(|scope| {
                    let (input1, data1) = scope.new_collection();
                    let (input2, data2) = scope.new_collection();
                    let joined = data1.join(&data2);
                    (input1, input2, joined.probe())
                });

                // Initial batch
                for i in 0..NUM_ITEMS / 2 {
                    input1.insert((i, format!("left_{}", i)));
                    input2.insert((i, format!("right_{}", i)));
                }
                input1.advance_to(1);
                input2.advance_to(1);
                input1.flush();
                input2.flush();
                worker.step_while(|| probe.less_than(&input1.time()));

                // Update batch - add more data
                for i in NUM_ITEMS / 2..NUM_ITEMS {
                    input1.insert((i, format!("left_{}", i)));
                }
                for i in NUM_ITEMS / 4..NUM_ITEMS * 3 / 4 {
                    input2.insert((i, format!("right_{}", i)));
                }
                input1.advance_to(2);
                input2.advance_to(2);
                input1.flush();
                input2.flush();
                worker.step_while(|| probe.less_than(&input1.time()));

                // Remove some data
                for i in 0..NUM_ITEMS / 4 {
                    input1.remove((i, format!("left_{}", i)));
                }
                input1.advance_to(3);
                input2.advance_to(3);
                input1.flush();
                input2.flush();
                worker.step_while(|| probe.less_than(&input1.time()));

                black_box(());
            });
        })
    });
}

criterion_group!(
    differential_join_benches,
    benchmark_differential_join,
    benchmark_baseline_join,
    benchmark_differential_join_updates,
);
criterion_main!(differential_join_benches);
