use std::collections::HashMap;

use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::channels::pact::Pipeline;
use timely::dataflow::operators::{Operator, ToStream};

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
        i.to_string()
    }
}

fn benchmark_timely<L, R>(c: &mut Criterion)
where
    L: JoinValue + 'static,
    R: JoinValue + 'static,
{
    c.bench_function(
        format!("join/{}/{}/timely", L::name(), R::name()).as_str(),
        |b| {
            b.iter(|| {
                timely::example(move |scope| {
                    let input1 = (0_usize..10_000).map(|i| (L::new(i), i)).to_stream(scope);
                    let input2 = (0_usize..10_000).map(|i| (R::new(i), i)).to_stream(scope);

                    input1.binary(&input2, Pipeline, Pipeline, "Join", |_cap, _info| {
                        let mut map1 = HashMap::<L, Vec<usize>>::new();
                        let mut map2 = HashMap::<R, Vec<usize>>::new();

                        move |input1, input2, _output| {
                            input1.for_each(|_time, data| {
                                for (key, val) in data.iter().cloned() {
                                    map1.entry(key).or_default().push(val);
                                }
                            });

                            input2.for_each(|_time, data| {
                                for (key, val) in data.iter().cloned() {
                                    map2.entry(key).or_default().push(val);
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
    join_timely,
    benchmark_timely::<usize, usize>,
    benchmark_timely::<usize, String>,
    benchmark_timely::<String, usize>,
    benchmark_timely::<String, String>,
);
criterion_main!(join_timely);
