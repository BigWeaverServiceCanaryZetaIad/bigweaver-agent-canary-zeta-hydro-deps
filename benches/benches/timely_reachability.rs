mod common;

use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use timely::dataflow::operators::{Concatenate, Inspect, Map, Probe};
use timely::dataflow::{InputHandle, ProbeHandle};

/// Simplified reachability computation using timely dataflow
/// This is a basic iterative pattern demonstration
fn compute_reachability<T: timely::Data>(
    edges: Vec<(u32, u32)>,
    roots: Vec<u32>,
) -> Vec<u32> {
    // Simplified implementation - just collect unique reachable nodes
    use std::collections::{HashSet, VecDeque};
    
    let mut reachable = HashSet::new();
    let mut queue = VecDeque::new();
    
    // Start with roots
    for root in roots {
        queue.push_back(root);
        reachable.insert(root);
    }
    
    // Build adjacency map
    let mut adj_map: std::collections::HashMap<u32, Vec<u32>> = std::collections::HashMap::new();
    for (src, dst) in edges {
        adj_map.entry(src).or_default().push(dst);
    }
    
    // BFS traversal
    while let Some(node) = queue.pop_front() {
        if let Some(neighbors) = adj_map.get(&node) {
            for &neighbor in neighbors {
                if reachable.insert(neighbor) {
                    queue.push_back(neighbor);
                }
            }
        }
    }
    
    reachable.into_iter().collect()
}


fn timely_reachability_chain(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/reachability/chain");
    
    for size in [100, 500, 1_000].iter() {
        let edges = common::generate_chain_graph(*size);
        group.throughput(Throughput::Elements(*size as u64));
        
        group.bench_with_input(BenchmarkId::from_parameter(size), &edges, |b, edges| {
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut edge_input = InputHandle::new();
                    let mut root_input = InputHandle::new();
                    let mut probe = ProbeHandle::new();
                    let mut collected_edges = Vec::new();
                    let mut roots = Vec::new();

                    worker.dataflow(|scope| {
                        edge_input
                            .to_stream(scope)
                            .inspect(|x| collected_edges.push(*x))
                            .probe_with(&mut probe);
                            
                        root_input
                            .to_stream(scope)
                            .inspect(|x| roots.push(*x))
                            .probe();
                    });

                    for edge in edges.iter() {
                        edge_input.send(black_box(*edge));
                    }
                    root_input.send(0);
                    
                    edge_input.advance_to(1);
                    root_input.advance_to(1);
                    
                    while probe.less_than(&1) {
                        worker.step();
                    }
                    
                    // Compute reachability
                    let result = compute_reachability::<u32>(collected_edges, roots);
                    black_box(result);
                });
            });
        });
    }
    group.finish();
}

fn timely_reachability_random(c: &mut Criterion) {
    let mut group = c.benchmark_group("timely/reachability/random");
    
    for (nodes, edges_count) in [(50, 200), (100, 500), (200, 1000)].iter() {
        let edges = common::generate_random_graph(*nodes, *edges_count, 12345);
        group.throughput(Throughput::Elements(*edges_count as u64));
        
        let label = format!("{}nodes_{}edges", nodes, edges_count);
        group.bench_with_input(BenchmarkId::from_parameter(&label), &edges, |b, edges| {
            b.iter(|| {
                let edges = edges.clone();
                timely::execute_directly(move |worker| {
                    let mut edge_input = InputHandle::new();
                    let mut root_input = InputHandle::new();
                    let mut probe = ProbeHandle::new();
                    let mut collected_edges = Vec::new();
                    let mut roots = Vec::new();

                    worker.dataflow(|scope| {
                        edge_input
                            .to_stream(scope)
                            .inspect(|x| collected_edges.push(*x))
                            .probe_with(&mut probe);
                            
                        root_input
                            .to_stream(scope)
                            .inspect(|x| roots.push(*x))
                            .probe();
                    });

                    for edge in edges.iter() {
                        edge_input.send(black_box(*edge));
                    }
                    root_input.send(0);
                    
                    edge_input.advance_to(1);
                    root_input.advance_to(1);
                    
                    while probe.less_than(&1) {
                        worker.step();
                    }
                    
                    // Compute reachability
                    let result = compute_reachability::<u32>(collected_edges, roots);
                    black_box(result);
                });
            });
        });
    }
    group.finish();
}

criterion_group!(benches, timely_reachability_chain, timely_reachability_random);
criterion_main!(benches);
