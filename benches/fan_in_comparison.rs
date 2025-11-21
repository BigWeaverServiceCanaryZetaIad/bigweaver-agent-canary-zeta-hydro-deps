//! Fan-In Benchmark Comparison
//!
//! Measures performance of merging multiple streams.

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use hydroflow_external_benchmarks::utils::NUM_INTS;

const NUM_STREAMS: usize = 10;

/// Timely Dataflow fan-in benchmark
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Concatenate, Inspect};
    
    c.bench_function("fan_in/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let streams: Vec<_> = (0..NUM_STREAMS)
                    .map(|i| (i..NUM_INTS).to_stream(scope))
                    .collect();
                
                scope.concatenate(streams).inspect(|i| {
                    black_box(i);
                });
            });
        });
    });
}

/// Hydroflow fan-in benchmark
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("fan_in/hydroflow", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                merged = union();
                
                source_iter(0..NUM_INTS) -> merged;
                source_iter(1..NUM_INTS) -> merged;
                source_iter(2..NUM_INTS) -> merged;
                source_iter(3..NUM_INTS) -> merged;
                source_iter(4..NUM_INTS) -> merged;
                source_iter(5..NUM_INTS) -> merged;
                source_iter(6..NUM_INTS) -> merged;
                source_iter(7..NUM_INTS) -> merged;
                source_iter(8..NUM_INTS) -> merged;
                source_iter(9..NUM_INTS) -> merged;
                
                merged -> for_each(|x| {
                    black_box(x);
                });
            };

            df.run_available_sync();
        });
    });
}

/// Baseline: Iterator concatenation
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("fan_in/baseline", |b| {
        b.iter(|| {
            let data: Vec<_> = (0..NUM_STREAMS)
                .flat_map(|i| i..NUM_INTS)
                .collect();
            
            for x in data {
                black_box(x);
            }
        });
    });
}

criterion_group!(
    fan_in_comparison,
    benchmark_timely,
    benchmark_hydroflow,
    benchmark_baseline,
);
criterion_main!(fan_in_comparison);
