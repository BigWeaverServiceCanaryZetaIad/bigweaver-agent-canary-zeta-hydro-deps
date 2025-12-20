use std::collections::HashMap;

use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::{
    channels::pact::Pipeline,
    operators::{Operator, ToStream},
};

trait JoinValue: Clone + std::hash::Hash + Eq {
    fn name() -> &'static str;
    fn new(i: usize) -> Self;
}

impl JoinValue for usize {
    fn name() -> &'static str {
        "usize"
    }

    fn new(i: usize) -> Self {
        i
    }
}

impl JoinValue for String {
    fn name() -> &'static str {
        "String"
    }

    fn new(i: usize) -> Self {
        format!("value{}", i)
    }
}

const NUM_INTS: usize = 100_000;

fn benchmark_timely<L, R>(c: &mut Criterion)
where
    L: 'static + JoinValue,
    R: 'static + JoinValue,
{
    c.bench_function(
        format!("join/{}/{}/timely", L::name(), R::name()).as_str(),
        |b| {
            b.iter(|| {
                timely::example(move |scope| {
                    let lhs = (0..NUM_INTS).map(|x| (x, L::new(x))).to_stream(scope);
                    let rhs = (0..NUM_INTS).map(|x| (x, R::new(x))).to_stream(scope);

                    lhs.binary(&rhs, Pipeline, Pipeline, "HashJoin", |_, _| {
                        let mut left_tab: HashMap<usize, Vec<L>> = HashMap::new();
                        let mut right_tab: HashMap<usize, Vec<R>> = HashMap::new();
                        let mut lvec: Vec<(usize, L)> = Vec::new();
                        let mut rvec: Vec<(usize, R)> = Vec::new();
                        move |left, right, output| {
                            left.for_each(|time, data| {
                                data.swap(&mut lvec);
                                let mut session = output.session(&time);

                                for (k, v) in lvec.drain(..) {
                                    if let Some(matches) = right_tab.get(&k) {
                                        for v2 in matches {
                                            session.give((k, v.clone(), v2.clone()))
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
                                            session.give((k, v2.clone(), v.clone()))
                                        }
                                    }

                                    right_tab.entry(k).or_insert_with(Vec::new).push(v);
                                }
                            });
                        }
                    });
                });
            })
        },
    );
}

criterion_group!(
    join_timely_bench,
    benchmark_timely<usize, usize>,
    benchmark_timely<String, String>,
);
criterion_main!(join_timely_bench);
