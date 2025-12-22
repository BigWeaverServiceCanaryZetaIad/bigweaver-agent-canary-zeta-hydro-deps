use criterion::{black_box, criterion_group, criterion_main, Criterion};
use std::sync::mpsc::channel;
use std::thread;
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

fn benchmark_pipeline(c: &mut Criterion) {
    c.bench_function("identity/pipeline", |b| {
        b.iter(|| {
            let (input, mut output) = channel();

            for _ in 0..NUM_OPS {
                let (tx, mut rx) = channel();
                std::mem::swap(&mut output, &mut rx);
                thread::spawn(move || {
                    for elt in rx {
                        tx.send(elt).unwrap();
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
        })
    });
}

fn benchmark_raw_copy(c: &mut Criterion) {
    c.bench_function("identity/copy", |b| {
        b.iter(|| {
            let mut vec: Vec<usize> = (0..NUM_INTS).collect();
            for _ in 0..NUM_OPS {
                vec = vec.iter().copied().collect();
            }
            vec.iter().for_each(|x| {
                black_box(x);
            });
        })
    });
}

fn benchmark_iter(c: &mut Criterion) {
    c.bench_function("identity/iter", |b| {
        b.iter(|| {
            (0..NUM_INTS).for_each(|x| {
                black_box(x);
            });
        })
    });
}

fn benchmark_iter_collect(c: &mut Criterion) {
    c.bench_function("identity/iter_collect", |b| {
        b.iter(|| {
            let data: Vec<_> = (0..NUM_INTS).collect();
            for _ in 1..NUM_OPS {
                let _data: Vec<_> = data.iter().map(|x| black_box(x)).collect();
            }
            data.iter().for_each(|x| {
                black_box(x);
            });
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("identity/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    op = op.map(|x| x)
                }

                op.inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}

criterion_group!(
    identity_dataflow,
    benchmark_timely,
    benchmark_pipeline,
    benchmark_iter,
    benchmark_iter_collect,
    benchmark_raw_copy,
);
criterion_main!(identity_dataflow);
