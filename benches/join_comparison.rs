//! Join Benchmark Comparison
//!
//! Compares join operation performance between:
//! - Timely Dataflow
//! - Hydroflow
//! - Baseline sequential implementation

use std::collections::HashMap;
use criterion::{Criterion, black_box, criterion_group, criterion_main, BatchSize};
use hydroflow_external_benchmarks::utils::NUM_JOIN_ELEMENTS;

type K = usize;
type L = String;
type R = usize;

/// Generate test data for joins
fn generate_join_data() -> (Vec<(K, L)>, Vec<(K, R)>) {
    let lhs: Vec<_> = (0..NUM_JOIN_ELEMENTS)
        .map(|i| (i % (NUM_JOIN_ELEMENTS / 100), format!("left_{}", i)))
        .collect();
    let rhs: Vec<_> = (0..NUM_JOIN_ELEMENTS)
        .map(|i| (i % (NUM_JOIN_ELEMENTS / 100), i * 2))
        .collect();
    (lhs, rhs)
}

/// Timely Dataflow join benchmark using binary operator
fn benchmark_timely_join(c: &mut Criterion) {
    c.bench_function("join/timely", |b| {
        b.iter_batched(
            generate_join_data,
            |(lhs, rhs)| {
                use timely::dataflow::operators::{ToStream, Inspect};
                use timely::dataflow::channels::pact::Pipeline;
                
                timely::example(|scope| {
                    let lhs_stream = lhs.to_stream(scope);
                    let rhs_stream = rhs.to_stream(scope);
                    
                    lhs_stream.binary(&rhs_stream, Pipeline, Pipeline, "HashJoin", |_, _| {
                        let mut left_tab: HashMap<K, Vec<L>> = HashMap::new();
                        let mut right_tab: HashMap<K, Vec<R>> = HashMap::new();
                        
                        move |left, right, output| {
                            // Process left input
                            left.for_each(|time, data| {
                                let mut session = output.session(&time);
                                for (k, l) in data.iter().cloned() {
                                    // Join with existing right entries
                                    if let Some(rs) = right_tab.get(&k) {
                                        for r in rs {
                                            session.give(((k, l.clone()), r.clone()));
                                        }
                                    }
                                    // Store in left table
                                    left_tab.entry(k).or_default().push(l);
                                }
                            });
                            
                            // Process right input
                            right.for_each(|time, data| {
                                let mut session = output.session(&time);
                                for (k, r) in data.iter().cloned() {
                                    // Join with existing left entries
                                    if let Some(ls) = left_tab.get(&k) {
                                        for l in ls {
                                            session.give(((k, l.clone()), r.clone()));
                                        }
                                    }
                                    // Store in right table
                                    right_tab.entry(k).or_default().push(r);
                                }
                            });
                        }
                    }).inspect(|x| {
                        black_box(x);
                    });
                });
            },
            BatchSize::LargeInput,
        );
    });
}

/// Hydroflow join benchmark
fn benchmark_hydroflow_join(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("join/hydroflow", |b| {
        b.iter_batched(
            generate_join_data,
            |(lhs, rhs)| {
                let mut df = dfir_syntax! {
                    lhs_input = source_iter(lhs);
                    rhs_input = source_iter(rhs);
                    
                    joined = join();
                    lhs_input -> [0]joined;
                    rhs_input -> [1]joined;
                    
                    joined -> for_each(|x| {
                        black_box(x);
                    });
                };
                
                df.run_available_sync();
            },
            BatchSize::LargeInput,
        );
    });
}

/// Baseline sequential hash join
fn benchmark_baseline_join(c: &mut Criterion) {
    c.bench_function("join/baseline", |b| {
        b.iter_batched(
            generate_join_data,
            |(lhs, rhs)| {
                let mut left_tab: HashMap<K, Vec<L>> = HashMap::new();
                for (k, l) in lhs {
                    left_tab.entry(k).or_default().push(l);
                }
                
                let mut results = Vec::new();
                for (k, r) in rhs {
                    if let Some(ls) = left_tab.get(&k) {
                        for l in ls {
                            results.push(((k, l.clone()), r.clone()));
                        }
                    }
                }
                
                for result in results {
                    black_box(result);
                }
            },
            BatchSize::LargeInput,
        );
    });
}

criterion_group!(
    join_comparison,
    benchmark_timely_join,
    benchmark_hydroflow_join,
    benchmark_baseline_join,
);
criterion_main!(join_comparison);
