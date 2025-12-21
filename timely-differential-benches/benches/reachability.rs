use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::io::{BufRead, BufReader, Cursor};
use std::rc::Rc;

use criterion::{criterion_group, criterion_main, Criterion};

lazy_static::lazy_static! {
    static ref EDGES: HashMap<usize, Vec<usize>> = {
        let cursor = Cursor::new(include_bytes!("reachability_edges.txt"));
        let reader = BufReader::new(cursor);

        let mut edges = HashMap::new();
        for line in reader.lines() {
            let line = line.unwrap();
            let mut nums = line.split_whitespace();
            let a = nums.next().unwrap().parse().unwrap();
            let b = nums.next().unwrap().parse().unwrap();
            assert!(nums.next().is_none());
            edges.entry(a).or_insert_with(Vec::new).push(b);
        }
        edges
    };
    static ref REACHABLE: HashSet<usize> = {
        let cursor = Cursor::new(include_bytes!("reachability_reachable.txt"));
        let reader = BufReader::new(cursor);

        let mut set = HashSet::new();
        for line in reader.lines() {
            let line = line.unwrap();
            set.insert(line.parse().unwrap());
        }
        set
    };
}

fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{
        Capture, Concat, ConnectLoop, Feedback, Filter, Map, ToStream,
    };

    let edges = &*EDGES;
    let reachable = &*REACHABLE;

    c.bench_function("reachability/timely", |b| {
        b.iter(|| {
            let edges = edges.clone();
            let receiver = timely::example(|scope| {
                let mut seen = HashSet::new();

                let (handle, stream) = scope.feedback(1);

                let stream_out = (1_usize..=1)
                    .to_stream(scope)
                    .concat(&stream)
                    .flat_map(move |x| edges.get(&x).cloned().into_iter().flatten())
                    .filter(move |x| seen.insert(*x));
                stream_out.clone().connect_loop(handle);

                stream_out.capture()
            });

            let reached: HashSet<_> = receiver
                .iter()
                .filter_map(|e| match e {
                    timely::dataflow::operators::capture::event::Event::Messages(_, vec) => {
                        Some(vec)
                    }
                    _ => None,
                })
                .flatten()
                .collect();

            assert_eq!(&reached, reachable);
        });
    });
}

criterion_group!(
    reachability_dataflow,
    benchmark_timely,
);
criterion_main!(reachability_dataflow);
