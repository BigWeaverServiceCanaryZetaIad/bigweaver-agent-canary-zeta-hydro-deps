//! Fan-Out Benchmark Comparison
//!
//! Measures performance of splitting streams to multiple consumers.

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use hydroflow_external_benchmarks::utils::NUM_INTS;

const NUM_CONSUMERS: usize = 10;

/// Timely Dataflow fan-out benchmark
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Map, Inspect};
    
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let stream = (0..NUM_INTS).to_stream(scope);
                
                // Timely automatically clones for multiple consumers
                for i in 0..NUM_CONSUMERS {
                    stream.map(move |x| x + i).inspect(|x| {
                        black_box(x);
                    });
                }
            });
        });
    });
}

/// Hydroflow fan-out benchmark
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("fan_out/hydroflow", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source = source_iter(0..NUM_INTS) -> tee();
                
                source[0] -> map(|x| x + 0) -> for_each(|x| { black_box(x); });
                source[1] -> map(|x| x + 1) -> for_each(|x| { black_box(x); });
                source[2] -> map(|x| x + 2) -> for_each(|x| { black_box(x); });
                source[3] -> map(|x| x + 3) -> for_each(|x| { black_box(x); });
                source[4] -> map(|x| x + 4) -> for_each(|x| { black_box(x); });
                source[5] -> map(|x| x + 5) -> for_each(|x| { black_box(x); });
                source[6] -> map(|x| x + 6) -> for_each(|x| { black_box(x); });
                source[7] -> map(|x| x + 7) -> for_each(|x| { black_box(x); });
                source[8] -> map(|x| x + 8) -> for_each(|x| { black_box(x); });
                source[9] -> map(|x| x + 9) -> for_each(|x| { black_box(x); });
            };

            df.run_available_sync();
        });
    });
}

/// Baseline: Clone-based splitting
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("fan_out/baseline", |b| {
        b.iter(|| {
            let data: Vec<_> = (0..NUM_INTS).collect();
            
            for i in 0..NUM_CONSUMERS {
                for &x in &data {
                    black_box(x + i);
                }
            }
        });
    });
}

criterion_group!(
    fan_out_comparison,
    benchmark_timely,
    benchmark_hydroflow,
    benchmark_baseline,
);
criterion_main!(fan_out_comparison);
