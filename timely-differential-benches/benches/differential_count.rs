use criterion::{black_box, criterion_group, criterion_main, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Count;
use std::collections::HashMap;

const NUM_ITEMS: usize = 100_000;
const NUM_UNIQUE: usize = 1_000;

fn benchmark_differential_count(c: &mut Criterion) {
    c.bench_function("differential_count/differential", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input, probe) = worker.dataflow(|scope| {
                    let (input, data) = scope.new_collection();
                    let counts = data.count();
                    (input, counts.probe())
                });

                // Insert data with repeated keys
                for i in 0..NUM_ITEMS {
                    input.insert((i % NUM_UNIQUE, format!("value{}", i)));
                }
                input.advance_to(1);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                black_box(());
            });
        })
    });
}

fn benchmark_baseline_count(c: &mut Criterion) {
    c.bench_function("differential_count/baseline", |b| {
        b.iter(|| {
            let mut counts: HashMap<usize, usize> = HashMap::new();
            
            for i in 0..NUM_ITEMS {
                let key = i % NUM_UNIQUE;
                *counts.entry(key).or_insert(0) += 1;
            }

            for (_key, count) in counts {
                black_box(count);
            }
        })
    });
}

fn benchmark_differential_count_updates(c: &mut Criterion) {
    c.bench_function("differential_count/differential_updates", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input, probe) = worker.dataflow(|scope| {
                    let (input, data) = scope.new_collection();
                    let counts = data.count();
                    (input, counts.probe())
                });

                // Initial batch
                for i in 0..NUM_ITEMS / 2 {
                    input.insert((i % NUM_UNIQUE, format!("value{}", i)));
                }
                input.advance_to(1);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                // Update batch - add more items
                for i in NUM_ITEMS / 2..NUM_ITEMS {
                    input.insert((i % NUM_UNIQUE, format!("value{}", i)));
                }
                input.advance_to(2);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                black_box(());
            });
        })
    });
}

criterion_group!(
    differential_count_benches,
    benchmark_differential_count,
    benchmark_baseline_count,
    benchmark_differential_count_updates,
);
criterion_main!(differential_count_benches);
