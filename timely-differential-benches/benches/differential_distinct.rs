use criterion::{black_box, criterion_group, criterion_main, Criterion};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Threshold;
use std::collections::HashSet;

const NUM_ITEMS: usize = 100_000;
const NUM_UNIQUE: usize = 50_000;

fn benchmark_differential_distinct(c: &mut Criterion) {
    c.bench_function("differential_distinct/differential", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input, probe) = worker.dataflow(|scope| {
                    let (input, data) = scope.new_collection();
                    let distinct = data.distinct();
                    (input, distinct.probe())
                });

                // Insert data with duplicates
                for i in 0..NUM_ITEMS {
                    input.insert(i % NUM_UNIQUE);
                }
                input.advance_to(1);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                black_box(());
            });
        })
    });
}

fn benchmark_baseline_distinct(c: &mut Criterion) {
    c.bench_function("differential_distinct/baseline", |b| {
        b.iter(|| {
            let mut distinct: HashSet<usize> = HashSet::new();
            
            for i in 0..NUM_ITEMS {
                distinct.insert(i % NUM_UNIQUE);
            }

            for item in distinct {
                black_box(item);
            }
        })
    });
}

fn benchmark_differential_distinct_updates(c: &mut Criterion) {
    c.bench_function("differential_distinct/differential_updates", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input, probe) = worker.dataflow(|scope| {
                    let (input, data) = scope.new_collection();
                    let distinct = data.distinct();
                    (input, distinct.probe())
                });

                // Initial batch
                for i in 0..NUM_ITEMS / 2 {
                    input.insert(i % NUM_UNIQUE);
                }
                input.advance_to(1);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                // Update batch - add more items (some duplicates, some new)
                for i in NUM_ITEMS / 2..NUM_ITEMS {
                    input.insert(i % NUM_UNIQUE);
                }
                input.advance_to(2);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                // Remove some items
                for i in 0..NUM_ITEMS / 4 {
                    input.remove(i % NUM_UNIQUE);
                }
                input.advance_to(3);
                input.flush();
                worker.step_while(|| probe.less_than(input.time()));

                black_box(());
            });
        })
    });
}

criterion_group!(
    differential_distinct_benches,
    benchmark_differential_distinct,
    benchmark_baseline_distinct,
    benchmark_differential_distinct_updates,
);
criterion_main!(differential_distinct_benches);
