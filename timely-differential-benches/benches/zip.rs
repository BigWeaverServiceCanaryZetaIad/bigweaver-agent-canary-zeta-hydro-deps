use std::collections::HashMap;

use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::{
    channels::pact::Pipeline,
    operators::{Operator, ToStream},
};

const NUM_INTS: usize = 1_000_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("zip/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let lhs = (0..NUM_INTS).map(|x| (x, x)).to_stream(scope);
                let rhs = (0..NUM_INTS).map(|x| (x, x)).to_stream(scope);

                lhs.binary(&rhs, Pipeline, Pipeline, "Zip", |_, _| {
                    let mut left_tab: HashMap<usize, Vec<usize>> = HashMap::new();
                    let mut right_tab: HashMap<usize, Vec<usize>> = HashMap::new();
                    let mut lvec: Vec<(usize, usize)> = Vec::new();
                    let mut rvec: Vec<(usize, usize)> = Vec::new();
                    move |left, right, output| {
                        left.for_each(|time, data| {
                            data.swap(&mut lvec);
                            let mut session = output.session(&time);

                            for (k, v) in lvec.drain(..) {
                                if let Some(matches) = right_tab.get(&k) {
                                    for v2 in matches {
                                        session.give((k, v, *v2))
                                    }
                                }

                                left_tab.entry(k).or_insert_with(Vec::new).push(v);
                            }
                        });

                        right.for_each(|time, data| {
                            data.swap(&mut rvec);
                            let mut session = output.session(&time);

                            for (k, v) in rvec.drain(..) {
                                if let Some(matches) = left_tab.get(&k) {
                                    for v2 in matches {
                                        session.give((k, *v2, v))
                                    }
                                }

                                right_tab.entry(k).or_insert_with(Vec::new).push(v);
                            }
                        });
                    }
                })
                .inspect(|x| {
                    black_box(x);
                });
            });
        })
    });
}

criterion_group!(
    zip_dataflow,
    benchmark_timely,
);
criterion_main!(zip_dataflow);
