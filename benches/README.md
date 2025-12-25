# Timely and Differential Dataflow Benchmarks

Benchmarks comparing Timely Dataflow and Differential Dataflow performance.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench reachability
```

## Benchmark Descriptions

### fork_join
Benchmarks fork-join dataflow patterns using:
- Timely Dataflow operators (Filter, Concatenate)
- Raw Rust implementation for comparison

### reachability
Graph reachability benchmarks using:
- Timely Dataflow operators (feedback loops, filters)
- Differential Dataflow operators (iterate, join, distinct)

## Data Files

- `reachability_edges.txt` - Graph edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable vertices for validation
