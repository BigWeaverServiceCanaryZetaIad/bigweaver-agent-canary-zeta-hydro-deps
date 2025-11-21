//! Arithmetic Benchmark Comparison
//!
//! Computational workload performance.

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use hydroflow_external_benchmarks::utils::NUM_INTS;

const NUM_OPS: usize = 20;

/// Timely Dataflow arithmetic benchmark
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Map, Inspect};
    
    c.bench_function("arithmetic/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut stream = (0..NUM_INTS).to_stream(scope);
                
                for _ in 0..NUM_OPS {
                    stream = stream.map(|x| x.wrapping_mul(3).wrapping_add(7));
                }
                
                stream.inspect(|x| {
                    black_box(x);
                });
            });
        });
    });
}

/// Hydroflow arithmetic benchmark
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("arithmetic/hydroflow", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(0..NUM_INTS)
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> map(|x| x.wrapping_mul(3).wrapping_add(7))
                -> for_each(|x| { black_box(x); });
            };

            df.run_available_sync();
        });
    });
}

/// Baseline: Iterator arithmetic
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("arithmetic/baseline", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();
            
            for _ in 0..NUM_OPS {
                data = data.into_iter()
                    .map(|x| x.wrapping_mul(3).wrapping_add(7))
                    .collect();
            }
            
            for x in data {
                black_box(x);
            }
        });
    });
}

criterion_group!(
    arithmetic_comparison,
    benchmark_timely,
    benchmark_hydroflow,
    benchmark_baseline,
);
criterion_main!(arithmetic_comparison);
