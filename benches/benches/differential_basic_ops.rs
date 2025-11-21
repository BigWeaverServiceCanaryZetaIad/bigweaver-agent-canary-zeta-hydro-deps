use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use differential_dataflow::input::InputSession;
use differential_dataflow::operators::{Count, Join, Reduce};
use timely::dataflow::operators::Probe;

fn differential_map(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/map");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_collection(scope)
                            .map(|x: u64| black_box(x * 2))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.insert(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_filter(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/filter");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_collection(scope)
                            .filter(|x: &u64| black_box(*x % 2 == 0))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.insert(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_join(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/join");
    
    for size in [100, 1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64 * 2));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input1 = InputSession::new();
                    let mut input2 = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let collection1 = input1.to_collection(scope);
                        let collection2 = input2.to_collection(scope);
                        
                        collection1
                            .join(&collection2)
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        let key = i % 100;
                        input1.insert((key, i));
                        input2.insert((key, i * 2));
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    input1.flush();
                    input2.flush();
                    
                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_count(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/count");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_collection(scope)
                            .count()
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.insert(i % 100); // Repeat values to test counting
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_reduce(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/reduce");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_collection(scope)
                            .map(|x: u64| (x % 100, x))
                            .reduce(|_key, input, output| {
                                let sum: u64 = input.iter().map(|(val, _)| *val).sum();
                                output.push((black_box(sum), 1));
                            })
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.insert(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();
                    
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn differential_incremental_update(c: &mut Criterion) {
    let mut group = c.benchmark_group("differential/incremental");
    
    for size in [1_000, 10_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputSession::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_collection(scope)
                            .map(|x: u64| (x % 100, x))
                            .count()
                            .probe_with(&mut probe);
                    });

                    // Initial batch
                    for i in 0..size {
                        input.insert(i as u64);
                    }
                    input.advance_to(1);
                    input.flush();
                    while probe.less_than(&1) {
                        worker.step();
                    }
                    
                    // Incremental update
                    for i in 0..100 {
                        input.insert(black_box(i as u64));
                    }
                    input.advance_to(2);
                    input.flush();
                    while probe.less_than(&2) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

criterion_group!(
    benches,
    differential_map,
    differential_filter,
    differential_join,
    differential_count,
    differential_reduce,
    differential_incremental_update
);
criterion_main!(benches);
