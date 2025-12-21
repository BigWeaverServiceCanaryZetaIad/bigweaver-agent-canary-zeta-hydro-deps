use criterion::{black_box, criterion_group, criterion_main, Criterion};
use timely::dataflow::operators::{Concatenate, Filter, Inspect, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 100_000;
const BRANCH_FACTOR: usize = 2;

fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("fork_join/raw", |b| {
        b.iter(|| {
            let mut parts = [(); BRANCH_FACTOR].map(|_| Vec::new());
            let mut data: Vec<_> = (0..NUM_INTS).collect();

            for _ in 0..NUM_OPS {
                for i in data.drain(..) {
                    parts[i % BRANCH_FACTOR].push(i);
                }

                for part in parts.iter_mut() {
                    data.append(part);
                }
            }
        })
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fork_join/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);
                for _ in 0..NUM_OPS {
                    let mut ops = Vec::new();

                    for i in 0..BRANCH_FACTOR {
                        ops.push(op.filter(move |x| x % BRANCH_FACTOR == i))
                    }

                    op = scope.concatenate(ops);
                }

                op.inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}

//         b.to_async(
//             tokio::runtime::Builder::new_current_thread()
//                 .build()
//                 .unwrap(),
//         )
//         .iter(|| {
//             async {

//                 type MyLatRepr =

//                 struct Even();
//                     type InLatRepr = MyLatRepr;
//                     type OutLatRepr = MyLatRepr;
//                         &self,
//                         item.filter(|i| 0 == i % 2)
//                     }
//                 }

//                 struct Odds();
//                     type InLatRepr = MyLatRepr;
//                     type OutLatRepr = MyLatRepr;
//                         &self,
//                         item.filter(|i| 1 == i % 2)
//                     }
//                 }

//                 ///// MAGIC NUMBER!!!!!!!! is NUM_OPS
//                 seq_macro::seq!(N in 0..20 {
//                 });

//             }
//         });
//     });
// }

//         b.to_async(
//             tokio::runtime::Builder::new_current_thread()
//                 .build()
//                 .unwrap(),
//         )
//         .iter(|| {
//             async {

//                 type MyLatRepr =

//                 struct SwitchEvenOdd();
//                     type InLatRepr = MyLatRepr;
//                         &self,
//                         let (a, b) = item.switch(|i| 0 == i % 2);
//                     }
//                 }

//                 ///// MAGIC NUMBER!!!!!!!! is NUM_OPS
//                 seq_macro::seq!(N in 0..20 {
//                 });

//             }
//         });
//     });
// }

//         b.to_async(
//             tokio::runtime::Builder::new_current_thread()
//                 .build()
//                 .unwrap(),
//         )
//         .iter(|| {
//             async {


//                 ///// MAGIC NUMBER!!!!!!!! is NUM_OPS
//                 seq_macro::seq!(N in 0..20 {
//                     let mut i = 0;
//                     let splits = [(); BRANCH_FACTOR].map(|_| {
//                         let j = i;
//                         i += 1;
//                         splitter.add_split().filter(move |x| ready(j == x % BRANCH_FACTOR))
//                     });
//                 });

//                 let mut stream = stream;
//                 loop {
//                     let item = stream.next().await;
//                     if item.is_none() {
//                         break;
//                     }
//                 }
//             }
//         });
//     });
// }

// criterion_group!(
//     name = fork_join_dataflow;
//     config = Criterion::default().with_profiler(PProfProfiler::new(100, Output::Flamegraph(None)));
// );
// criterion_group!(
    fork_join_dataflow,
    benchmark_timely,
);
criterion_group!(
    fork_join_dataflow,
    benchmark_timely,
);
criterion_main!(fork_join_dataflow);
