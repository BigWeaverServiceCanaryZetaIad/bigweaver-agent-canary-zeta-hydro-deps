use std::hint::black_box;
use std::collections::HashMap;

use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::compiled::pull::{HalfSetJoinState, symmetric_hash_join_into_iter};
use rand::SeedableRng;
use rand::distributions::Distribution;
use rand::rngs::StdRng;
use timely::dataflow::channels::pact::Pipeline;
use timely::dataflow::operators::{Operator, ToStream};
use differential_dataflow::input::Input;
use differential_dataflow::operators::Join;

fn ops(c: &mut Criterion) {
    let mut rng = StdRng::from_entropy();

    c.bench_function("symmetric_hash_join/no_match", |b| {
        let lhs: Vec<_> = (0..3000).map(|v| (v, ())).collect();
        let rhs: Vec<_> = (0..3000).map(|v| (v + 50000, ())).collect();

        b.iter(|| {
            let (mut lhs_state, mut rhs_state) =
                black_box((HalfSetJoinState::default(), HalfSetJoinState::default()));
            let join = symmetric_hash_join_into_iter(
                black_box(lhs.iter().cloned()),
                black_box(rhs.iter().cloned()),
                &mut lhs_state,
                &mut rhs_state,
                false,
            );

            for v in join {
                black_box(v);
            }
        });
    });

    c.bench_function("symmetric_hash_join/match_keys_diff_values", |b| {
        let lhs: Vec<_> = (0..3000).map(|v| (v, v)).collect();
        let rhs: Vec<_> = (0..3000).map(|v| (v, v + 50000)).collect();

        b.iter(|| {
            let (mut lhs_state, mut rhs_state) =
                black_box((HalfSetJoinState::default(), HalfSetJoinState::default()));
            let join = symmetric_hash_join_into_iter(
                black_box(lhs.iter().cloned()),
                black_box(rhs.iter().cloned()),
                &mut lhs_state,
                &mut rhs_state,
                false,
            );

            for v in join {
                black_box(v);
            }
        });
    });

    c.bench_function("symmetric_hash_join/match_keys_same_values", |b| {
        let lhs: Vec<_> = (0..3000).map(|v| (v, v)).collect();
        let rhs: Vec<_> = (0..3000).map(|v| (v, v)).collect();

        b.iter(|| {
            let (mut lhs_state, mut rhs_state) =
                black_box((HalfSetJoinState::default(), HalfSetJoinState::default()));
            let join = symmetric_hash_join_into_iter(
                black_box(lhs.iter().cloned()),
                black_box(rhs.iter().cloned()),
                &mut lhs_state,
                &mut rhs_state,
                false,
            );
            for v in join {
                black_box(v);
            }
        });
    });

    c.bench_function(
        "symmetric_hash_join/zipf_keys_low_contention_unique_values",
        |b| {
            let dist = rand_distr::Zipf::new(8000, 0.5).unwrap();

            let lhs: Vec<_> = (0..2000)
                .map(|v| (dist.sample(&mut rng) as usize, v))
                .collect();

            let rhs: Vec<_> = (0..2000)
                .map(|v| (dist.sample(&mut rng) as usize, v + 8000))
                .collect();

            b.iter(|| {
                let (mut lhs_state, mut rhs_state) =
                    black_box((HalfSetJoinState::default(), HalfSetJoinState::default()));
                let join = symmetric_hash_join_into_iter(
                    black_box(lhs.iter().cloned()),
                    black_box(rhs.iter().cloned()),
                    &mut lhs_state,
                    &mut rhs_state,
                    false,
                );

                for v in join {
                    black_box(v);
                }
            });
        },
    );

    c.bench_function(
        "symmetric_hash_join/zipf_keys_high_contention_unique_values",
        |b| {
            let dist = rand_distr::Zipf::new(8000, 4.0).unwrap();

            let lhs: Vec<_> = (0..1000)
                .map(|v| (dist.sample(&mut rng) as usize, v))
                .collect();

            let rhs: Vec<_> = (0..1000)
                .map(|v| (dist.sample(&mut rng) as usize, v + 8000))
                .collect();

            b.iter(|| {
                let (mut lhs_state, mut rhs_state) =
                    black_box((HalfSetJoinState::default(), HalfSetJoinState::default()));
                let join = symmetric_hash_join_into_iter(
                    black_box(lhs.iter().cloned()),
                    black_box(rhs.iter().cloned()),
                    &mut lhs_state,
                    &mut rhs_state,
                    false,
                );

                for v in join {
                    black_box(v);
                }
            });
        },
    );
}

fn timely_ops(c: &mut Criterion) {
    c.bench_function("symmetric_hash_join/timely/match_keys_diff_values", |b| {
        let lhs: Vec<_> = (0..3000).map(|v| (v, v)).collect();
        let rhs: Vec<_> = (0..3000).map(|v| (v, v + 50000)).collect();

        b.iter(|| {
            timely::example(|scope| {
                let lhs_stream = lhs.to_stream(scope);
                let rhs_stream = rhs.to_stream(scope);

                lhs_stream.binary(&rhs_stream, Pipeline, Pipeline, "HashJoin", |_, _| {
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
                                left_tab.entry(k).or_default().push(v);
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
                                right_tab.entry(k).or_default().push(v);
                            }
                        });
                    }
                })
                .inspect(|v| { black_box(v); });
            });
        });
    });
}

fn differential_ops(c: &mut Criterion) {
    c.bench_function("symmetric_hash_join/differential/match_keys_diff_values", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let probe = worker.dataflow::<u32, _, _>(|scope| {
                    let lhs: Vec<_> = (0..3000).map(|v| (v, v)).collect();
                    let rhs: Vec<_> = (0..3000).map(|v| (v, v + 50000)).collect();
                    
                    let lhs_collection = scope.new_collection_from(lhs).1;
                    let rhs_collection = scope.new_collection_from(rhs).1;

                    let joined = lhs_collection.join(&rhs_collection);
                    joined.inspect(|v| { black_box(v); });
                    
                    joined.probe()
                });

                worker.step_while(|| !probe.done());
            });
        });
    });
}

criterion_group!(symmetric_hash_join, ops, timely_ops, differential_ops);
criterion_main!(symmetric_hash_join);
