//! Fork-Join Benchmark Comparison
//!
//! Split, process differently, and merge patterns.

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use hydroflow_external_benchmarks::utils::NUM_INTS;

/// Timely Dataflow fork-join benchmark
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Filter, Concatenate, Inspect};
    
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let stream = (0..NUM_INTS).to_stream(scope);
                let even = stream.filter(|x| x % 2 == 0);
                let odd = stream.filter(|x| x % 2 != 0);
                
                scope.concatenate(vec![even, odd]).inspect(|x| {
                    black_box(x);
                });
            });
        });
    });
}

/// Hydroflow fork-join benchmark
fn benchmark_hydroflow(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("fork_join/hydroflow", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source = source_iter(0..NUM_INTS) -> tee();
                
                even = source[0] -> filter(|x| x % 2 == 0);
                odd = source[1] -> filter(|x| x % 2 != 0);
                
                merged = union();
                even -> merged;
                odd -> merged;
                
                merged -> for_each(|x| {
                    black_box(x);
                });
            };

            df.run_available_sync();
        });
    });
}

/// Baseline: Iterator-based fork-join
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("fork_join/baseline", |b| {
        b.iter(|| {
            let data: Vec<_> = (0..NUM_INTS).collect();
            
            let even: Vec<_> = data.iter().filter(|x| *x % 2 == 0).copied().collect();
            let odd: Vec<_> = data.iter().filter(|x| *x % 2 != 0).copied().collect();
            
            for x in even.into_iter().chain(odd) {
                black_box(x);
            }
        });
    });
}

criterion_group!(
    fork_join_comparison,
    benchmark_timely,
    benchmark_hydroflow,
    benchmark_baseline,
);
criterion_main!(fork_join_comparison);
