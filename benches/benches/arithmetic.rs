use std::sync::mpsc::channel;
use std::thread;

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use static_assertions::const_assert;
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_pipeline(c: &mut Criterion) {
    c.bench_function("arithmetic/pipeline", |b| {
        b.iter(|| {
            let (input, mut output) = channel();

            for _ in 0..NUM_OPS {
                let (tx, mut rx) = channel();
                std::mem::swap(&mut output, &mut rx);
                thread::spawn(move || {
                    for elt in rx {
                        tx.send(elt + 1).unwrap();
                    }
                });
            }

            for i in 0..NUM_INTS {
                input.send(i).unwrap();
            }
            drop(input);
            for elt in output {
                black_box(elt);
            }
        });
    });
}

// This benchmark just copies around a bunch of data with basically zero
// overhead, so this should theoretically be the fastest achievable (with a
// single thread).
fn benchmark_raw_copy(c: &mut Criterion) {
    c.bench_function("arithmetic/raw", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();
            let mut next = Vec::new();

            for _ in 0..NUM_OPS {
                next.extend(data.drain(..).map(|x| x + 1));
                std::mem::swap(&mut data, &mut next);
            }

            for elt in data {
                black_box(elt);
            }
        })
    });
}

fn benchmark_iter(c: &mut Criterion) {
    c.bench_function("arithmetic/iter", |b| {
        b.iter(|| {
            let iter = 0..NUM_INTS;

            ///// MAGIC NUMBER!!!!!!!! is NUM_OPS
            seq_macro::seq!(_ in 0..20 {
                let iter = iter.map(|x| x + 1);
            });

            let data: Vec<_> = iter.collect();

            for elt in data {
                black_box(elt);
            }
        });
    });
}

fn benchmark_iter_collect(c: &mut Criterion) {
    c.bench_function("arithmetic/iter-collect", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();

            for _ in 0..NUM_OPS {
                let iter = data.into_iter();
                let iter = iter.map(|x| x + 1);
                data = iter.collect();
            }

            for elt in data {
                black_box(elt);
            }
        });
    });
}

fn benchmark_hydroflow_compiled(c: &mut Criterion) {
    use dfir_rs::sinktools::{SinkBuild, SinkBuilder, ToSinkBuild};

    c.bench_function("arithmetic/dfir_rs/compiled", |b| {
        b.to_async(
            tokio::runtime::Builder::new_current_thread()
                .build()
                .unwrap(),
        )
        .iter(|| async {
            let sink = SinkBuilder::<usize>::new()
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
                .map(|x| x + 1)
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

fn benchmark_hydroflow_compiled_no_cheating(c: &mut Criterion) {
    use dfir_rs::sinktools::{SinkBuild, SinkBuilder, ToSinkBuild};

    c.bench_function("arithmetic/dfir_rs/compiled_no_cheating", |b| {
        b.to_async(
            tokio::runtime::Build