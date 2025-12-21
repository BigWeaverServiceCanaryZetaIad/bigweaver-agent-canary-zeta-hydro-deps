use criterion::{black_box, criterion_group, criterion_main, Criterion};
// use timely::dataflow::operators::Operator;

const NUM_INTS: usize = 1_000_000;

// fn benchmark_timely(c: &mut Criterion) {
//     c.bench_function("timely", |b| {
//         b.iter(|| {
//             unimplemented!();

//             // timely::example(move |scope| {
//             //     let lhs = (0..NUM_INTS).map(|x| (x, x)).to_stream(scope);
//             //     let rhs = (0..NUM_INTS).map(|x| (x, x)).to_stream(scope);

//             //     lhs.binary(&rhs, Pipeline, Pipeline, "HashJoin", |_, _| {
//             //         let mut left_tab: HashMap<usize, Vec<usize>> = HashMap::new();
//             //         let mut right_tab: HashMap<usize, Vec<usize>> = HashMap::new();
//             //         let mut lvec: Vec<(usize, usize)> = Vec::new();
//             //         let mut rvec: Vec<(usize, usize)> = Vec::new();
//             //         move |left, right, output| {
//             //             left.for_each(|time, data| {
//             //                 data.swap(&mut lvec);
//             //                 let mut session = output.session(&time);

//             //                 for (k, v) in lvec.drain(..) {
//             //                     if let Some(matches) = right_tab.get(&k) {
//             //                         for v2 in matches {
//             //                             session.give((k, v, v2.clone()))
//             //                         }
//             //                     }

//             //                     left_tab.entry(k).or_insert_with(Vec::new).push(v);
//             //                 }
//             //             });

//             //             right.for_each(|time, data| {
//             //                 data.swap(&mut rvec);
//             //                 let mut session = output.session(&time);

//             //                 for (k, v) in rvec.drain(..) {
//             //                     if let Some(matches) = left_tab.get(&k) {
//             //                         for v2 in matches {
//             //                             session.give((k, v2.clone(), v))
//             //                         }
//             //                     }

//             //                     right_tab.entry(k).or_insert_with(Vec::new).push(v);
//             //                 }
//             //             });
//             //         }
//             //     });
//             // });
//         })
//     });
// }

// fn benchmark_sol(c: &mut Criterion) {
//     c.bench_function("sol", |b| {
//         b.iter(|| {
//             unimplemented!();

//             // let iter_a = (0..NUM_INTS).map(|x| (x, x));
//             // let iter_b = (0..NUM_INTS).map(|x| (x, x));
//             // let mut items_a = HashMap::new();
//             // let mut items_b = HashMap::new();

//             // for (key, val_a) in iter_a {
//             //     items_a.entry(key)
//             //         .or_insert_with(Vec::new)
//             //         .push(val_a);
//             //     if let Some(vals_b) = items_b.get(&key) {
//             //         for val_b in vals_b {
//             //             black_box((key, val_a, val_b));
//             //         }
//             //     }
//             // }
//             // for (key, val_b) in iter_b {
//             //     items_b.entry(key)
//             //         .or_insert_with(Vec::new)
//             //         .push(val_b);
//             //     if let Some(vals_a) = items_a.get(&key) {
//             //         for val_a in vals_a {
//             //             black_box((key, val_a, val_b));
//             //         }
//             //     }
//             // }
//         });
//     });
// }

criterion_group!(
    zip_dataflow,
    // benchmark_timely,
    // benchmark_sol,
);
criterion_main!(zip_dataflow);
