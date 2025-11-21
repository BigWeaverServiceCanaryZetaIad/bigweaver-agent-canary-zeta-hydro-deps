//! Identity Benchmark Comparison
//!
//! Compares throughput of simple pass-through operations between:
//! - Timely Dataflow
//! - Hydroflow (various modes)
//! - Baseline iterator implementation

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use hydroflow_external_benchmarks::utils::{NUM_OPS, NUM_INTS};

/// Timely Dataflow identity benchmark
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("identity/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                use timely::dataflow::operators::{ToStream, Map, Inspect};
                
                let mut op = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    op = op.map(black_box);
                }
                op.inspect(|i| {
                    black_box(i);
                });
            });
        });
    });
}

/// Hydroflow compiled benchmark (reference implementation)
fn benchmark_hydroflow_compiled(c: &mut Criterion) {
    use dfir_rs::sinktools::{SinkBuild, SinkBuilder, ToSinkBuild};

    c.bench_function("identity/hydroflow/compiled", |b| {
        b.to_async(
            tokio::runtime::Builder::new_current_thread()
                .build()
                .unwrap(),
        )
        .iter(|| async {
            let sink = SinkBuilder::<usize>::new()
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .map(black_box)
                .for_each(|x| {
                    black_box(x);
                });

            (0..NUM_INTS)
                .iter_to_sink_build()
                .send_to(sink)
                .await
                .unwrap();
        });
    });
}

/// Hydroflow scheduled benchmark (reference implementation)
fn benchmark_hydroflow_scheduled(c: &mut Criterion) {
    use dfir_rs::scheduled::graph::Dfir;
    use dfir_rs::scheduled::handoff::{Iter, VecHandoff};
    use dfir_rs::scheduled::graph_ext::GraphExt;

    c.bench_function("identity/hydroflow/scheduled", |b| {
        b.iter(|| {
            let mut df = Dfir::new();

            let (next_send, mut next_recv) = df.make_edge::<_, VecHandoff<usize>>("end");

            let mut sent = false;
            df.add_subgraph_source("source", next_send, move |_ctx, send| {
                if !sent {
                    sent = true;
                    send.give(Iter(0..NUM_INTS));
                }
            });
            
            for _ in 0..NUM_OPS {
                let (next_send, next_next_recv) = df.make_edge("handoff");

                df.add_subgraph_in_out("identity", next_recv, next_send, |_ctx, recv, send| {
                    send.give(Iter(recv.take_inner().into_iter()));
                });

                next_recv = next_next_recv;
            }

            df.add_subgraph_sink("sink", next_recv, |_ctx, recv| {
                for x in recv.take_inner() {
                    black_box(x);
                }
            });

            df.run_available_sync();
        });
    });
}

/// Hydroflow surface syntax benchmark (reference implementation)
fn benchmark_hydroflow_surface(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    use dfir_rs::scheduled::graph_ext::GraphExt;
    use static_assertions::const_assert;

    const_assert!(NUM_OPS == 20);
    c.bench_function("identity/hydroflow/surface", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(black_box(0..NUM_INTS))

                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)

                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)
                -> map(black_box)

                -> for_each(|x| { black_box(x); });
            };

            df.run_available_sync();
        })
    });
}

/// Baseline: Raw iteration benchmark
fn benchmark_baseline_iter(c: &mut Criterion) {
    c.bench_function("identity/baseline/iter", |b| {
        b.iter(|| {
            let iter = 0..NUM_INTS;

            ///// MAGIC NUMBER!!!!!!!! is NUM_OPS
            seq_macro::seq!(_ in 0..20 {
                let iter = iter.map(black_box);
            });

            let data: Vec<_> = iter.collect();

            for elt in data {
                black_box(elt);
            }
        });
    });
}

criterion_group!(
    identity_comparison,
    benchmark_timely,
    benchmark_hydroflow_compiled,
    benchmark_hydroflow_scheduled,
    benchmark_hydroflow_surface,
    benchmark_baseline_iter,
);
criterion_main!(identity_comparison);
