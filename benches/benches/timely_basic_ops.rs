use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::operators::{Concatenate, Exchange, Filter, Map, Probe};
use timely::dataflow::InputHandle;

fn timely_map(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/map");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .map(|x: u64| black_box(x * 2))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn timely_filter(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/filter");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .filter(|x: &u64| black_box(*x % 2 == 0))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn timely_exchange(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/exchange");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .exchange(|x: &u64| black_box(*x))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    while probe.less_than(input.time()) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn timely_concatenate(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/concatenate");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64 * 2));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input1 = InputHandle::new();
                    let mut input2 = InputHandle::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        let stream1 = input1.to_stream(scope);
                        let stream2 = input2.to_stream(scope);
                        
                        stream1
                            .concatenate(stream2)
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input1.send(i as u64);
                        input2.send((i + size) as u64);
                    }
                    input1.advance_to(1);
                    input2.advance_to(1);
                    while probe.less_than(&1) {
                        worker.step();
                    }
                });
            });
        });
    }
    group.finish();
}

fn timely_chain_map(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/chain_map");
    
    for size in [1_000, 10_000, 100_000].iter() {
        group.throughput(Throughput::Elements(*size as u64));
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut input = InputHandle::new();
                    let mut probe = timely::dataflow::ProbeHandle::new();

                    worker.dataflow(|scope| {
                        input
                            .to_stream(scope)
                            .map(|x: u64| black_box(x * 2))
                            .map(|x| black_box(x + 1))
                            .map(|x| black_box(x / 2))
                            .probe_with(&mut probe);
                    });

                    for i in 0..size {
                        input.send(i as u64);
                    }
                    input.advance_to(1);
                    while probe.less_than(input.time()) {
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
    timely_map,
    timely_filter,
    timely_exchange,
    timely_concatenate,
    timely_chain_map
);
criterion_main!(benches);
