use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};
use timely::dataflow::operators::{ToStream, Probe};
use timely::dataflow::channels::pact::Pipeline;
use timely::dataflow::operators::generic::operator::Operator;
use differential_dataflow::input::Input;
use differential_dataflow::operators::Join;

/// Benchmark for graph reachability using differential-dataflow
fn reachability_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("reachability");
    
    for size in [100, 1000, 10000].iter() {
        group.bench_with_input(BenchmarkId::from_parameter(size), size, |b, &size| {
            b.iter(|| {
                timely::execute_directly(move |worker| {
                    let mut probe = timely::dataflow::ProbeHandle::new();
                    
                    let (mut nodes, mut edges) = worker.dataflow(|scope| {
                        let (node_input, nodes) = scope.new_collection();
                        let (edge_input, edges) = scope.new_collection();
                        
                        // Compute transitive closure
                        let mut reachable = nodes.clone();
                        reachable = reachable.iterate(|inner| {
                            let edges = edges.enter(&inner.scope());
                            let nodes = inner.clone();
                            
                            nodes.join_map(&edges, |_src, _, dst| *dst)
                                 .concat(&nodes)
                                 .distinct()
                        });
                        
                        reachable.probe_with(&mut probe);
                        
                        (node_input, edge_input)
                    });
                    
                    // Insert test data
                    for i in 0..size {
                        nodes.insert((i, ()));
                        if i > 0 {
                            edges.insert((i - 1, i));
                        }
                    }
                    
                    nodes.advance_to(1);
                    edges.advance_to(1);
                    nodes.flush();
                    edges.flush();
                    
                    worker.step_while(|| probe.less_than(&1));
                });
            });
        });
    }
    
    group.finish();
}

criterion_group!(benches, reachability_benchmark);
criterion_main!(benches);
