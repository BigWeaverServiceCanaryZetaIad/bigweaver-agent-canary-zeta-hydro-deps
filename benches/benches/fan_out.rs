use criterion::{Criterion, black_box, criterion_group, criterion_main};
use static_assertions::const_assert;
use timely::dataflow::operators::{Map, ToStream};

const NUM_OPS: usize = 20;
const NUM_INTS: usize = 1_000_000;

// Hydroflow benchmark function removed - it remains in the main repository for comparison

// fn benchmark_hydroflow_teer(c: &mut Criterion) {
//     c.bench_function("fan_out/dfir/teer", |b| {
//         b.iter(|| {
//             let mut df = Hydroflow::new();
//             let output = df.add_source(|send: &SendCtx<TeeingHandoff<_>>| {
//                 send.give((0..NUM_INTS).collect());
//             });

//             for _ in 0..(NUM_OPS - 1) {
//                 let input = df.add_sink(|recv| {
//                     for v in recv.take_inner() {
//                         black_box(v);
//                     }
//                 });

//                 df.add_edge(output.clone(), input);
//             }

//             let input = df.add_sink(|recv| {
//                 for v in recv.take_inner() {
//                     black_box(v);
//                 }
//             });

//             df.add_edge(output, input);

//             df.tick();
//         })
//     });
// }

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("fan_out/timely", |b| {
        b.iter(|| {
            timely::example(move |scope| {
                let source = (0..NUM_INTS).to_stream(scope);

                let _sinks: Vec<_> = (0..NUM_OPS)
                    .map(|_| source.clone().map(black_box))
                    .collect();
            });
        })
    });
}

fn benchmark_sol(c: &mut Criterion) {
    c.bench_function("fan_out/sol", |b| {
        b.iter(|| {
            for x in 0..NUM_INTS {
                for _ in 1..NUM_OPS {
                    black_box(x);
                }
            }
        })
    });
}

criterion_group!(
    fan_out_dataflow,
    benchmark_timely,
    benchmark_sol,
);
criterion_main!(fan_out_dataflow);
