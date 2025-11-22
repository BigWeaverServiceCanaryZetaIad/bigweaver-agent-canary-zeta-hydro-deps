use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{Inspect, Map, ToStream};

const NUM_WORDS: usize = 100_000;

static WORDS: &str = include_str!("words_alpha.txt");

fn benchmark_timely<O>(c: &mut Criterion)
where
    O: Fn(String) -> String + 'static,
{
    let words: Vec<String> = WORDS.lines().map(String::from).cycle().take(NUM_WORDS).collect();

    c.bench_function("upcase/timely", move |b| {
        b.iter(|| {
            let words = words.clone();
            let operation = |s: String| s.to_uppercase();

            timely::example(move |scope| {
                words
                    .to_stream(scope)
                    .map(operation)
                    .inspect(|x| {
                        black_box(x);
                    });
            });
        })
    });
}

criterion_group!(
    upcase_dataflow,
    benchmark_timely::<fn(String) -> String>,
);
criterion_main!(upcase_dataflow);
