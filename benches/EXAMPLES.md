# Benchmark Examples and Explanations

This document provides detailed explanations of the benchmark implementations and how they compare different dataflow frameworks.

## Understanding Benchmark Structure

Each benchmark typically includes multiple implementations:
1. **Baseline implementations** - Raw Rust, iterators, channels
2. **Timely-dataflow** - Using timely operators
3. **Differential-dataflow** - Using differential operators (when applicable)
4. **Hydro (dfir_rs)** - Using Hydro's various APIs

This allows direct performance comparison across approaches.

## Example: Identity Benchmark

The identity benchmark (`benches/identity.rs`) tests the overhead of passing data through transformation pipelines with minimal actual work.

### Configuration
```rust
const NUM_OPS: usize = 20;      // Number of operations in pipeline
const NUM_INTS: usize = 1_000_000;  // Number of data items
```

### 1. Raw Copy (Baseline)
```rust
fn benchmark_raw_copy(c: &mut Criterion) {
    c.bench_function("identity/raw", |b| {
        b.iter(|| {
            let mut data: Vec<_> = (0..NUM_INTS).collect();
            let mut next = Vec::new();
            
            // Copy data NUM_OPS times
            for _ in 0..NUM_OPS {
                next.append(&mut data);
                std::mem::swap(&mut data, &mut next);
            }
            
            for elt in data {
                black_box(elt);  // Prevent optimization
            }
        })
    });
}
```
**Purpose**: Establishes theoretical minimum overhead

### 2. Iterator Chain
```rust
fn benchmark_iter(c: &mut Criterion) {
    c.bench_function("identity/iter", |b| {
        b.iter(|| {
            let iter = 0..NUM_INTS;
            
            // Chain 20 map operations
            seq_macro::seq!(_ in 0..20 {
                let iter = iter.map(black_box);
            });
            
            let data: Vec<_> = iter.collect();
            for elt in data {
                black_box(elt);
            }
        });
    });
}
```
**Purpose**: Tests Rust's iterator optimization

### 3. Timely-Dataflow
```rust
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("identity/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                let mut op = (0..NUM_INTS).to_stream(scope);
                
                // Chain NUM_OPS map operations
                for _ in 0..NUM_OPS {
                    op = op.map(black_box)
                }
                
                op.inspect(|i| {
                    black_box(i);
                });
            });
        })
    });
}
```
**Purpose**: Tests timely's streaming operator overhead

### 4. Hydro (dfir_rs) - Surface Syntax
```rust
fn benchmark_hydroflow_surface(c: &mut Criterion) {
    c.bench_function("identity/dfir_rs/surface", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                source_iter(black_box(0..NUM_INTS))
                -> map(black_box)
                -> map(black_box)
                // ... (20 map operations)
                -> for_each(|x| { black_box(x); });
            };
            
            df.run_available_sync();
        })
    });
}
```
**Purpose**: Tests Hydro's high-level surface syntax

## Example: Reachability Benchmark

The reachability benchmark (`benches/reachability.rs`) tests graph reachability algorithms - a classic dataflow problem.

### Problem Setup
- Graph edges loaded from `reachability_edges.txt`
- Starting from node 1
- Find all reachable nodes
- Verify against known reachable set

### 1. Timely Implementation
```rust
fn benchmark_timely(c: &mut Criterion) {
    let edges = &*EDGES;  // HashMap<usize, Vec<usize>>
    let reachable = &*REACHABLE;  // HashSet<usize>
    
    c.bench_function("reachability/timely", |b| {
        b.iter(|| {
            let edges = edges.clone();
            let receiver = timely::example(|scope| {
                let mut seen = HashSet::new();
                
                // Create feedback loop
                let (handle, stream) = scope.feedback(1);
                
                // Start from node 1, then process feedback
                let stream_out = (1_usize..=1)
                    .to_stream(scope)
                    .concat(&stream)
                    .flat_map(move |x| 
                        edges.get(&x).cloned().into_iter().flatten()
                    )
                    .filter(move |x| seen.insert(*x));  // Only new nodes
                    
                stream_out.connect_loop(handle);
                stream_out.capture()
            });
            
            // Collect results
            let reached: HashSet<_> = receiver
                .iter()
                .filter_map(|e| match e {
                    Event::Messages(_, vec) => Some(vec),
                    _ => None,
                })
                .flatten()
                .collect();
                
            assert_eq!(&reached, reachable);
        });
    });
}
```

### 2. Differential-Dataflow Implementation
```rust
fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("reachability/differential", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let probe = worker.dataflow(|scope| {
                    // Load edges as collection
                    let edges = scope.new_collection_from(
                        EDGE_VEC.iter().cloned()
                    ).1;
                    
                    // Start from node 1
                    let roots = scope.new_collection_from(
                        Some((1, ()))
                    ).1;
                    
                    // Iterate to fixed point
                    let reachable = roots.iterate(|inner| {
                        let edges = edges.enter(&inner.scope());
                        
                        // Join with edges, project destinations
                        inner
                            .join_map(&edges, |_src, (), dst| (*dst, ()))
                            .concat(&roots.enter(&inner.scope()))
                            .distinct()  // Remove duplicates
                    });
                    
                    reachable.probe()
                });
                
                worker.step_while(|| probe.less_than(&Default::default()));
            });
        });
    });
}
```

### 3. Hydro (dfir_rs) Implementation
```rust
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("reachability/dfir_rs", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                // Define initial nodes
                reached_set = union() -> tee();
                source_iter([1]) -> [0]reached_set;
                
                // Iterate: find neighbors of reached nodes
                reached_set[1]
                    -> flat_map(|node| {
                        EDGES.get(&node)
                            .cloned()
                            .unwrap_or_default()
                    })
                    -> [1]reached_set;
                    
                // Collect results
                reached_set[2]
                    -> unique()
                    -> for_each(|x| {
                        black_box(x);
                    });
            };
            
            df.run_available_sync();
        });
    });
}
```

## Example: Join Benchmark

Tests the performance of join operations - a critical operation in dataflow systems.

### Setup
```rust
const NUM_KEYS: usize = 10_000;
const NUM_OPS_PER_KEY: usize = 100;
```

Creates two collections and joins them on matching keys.

### Timely Implementation
```rust
use timely::dataflow::operators::{Concat, Join, Map, ToStream};

timely::example(|scope| {
    let left = (0..NUM_KEYS)
        .flat_map(|k| (0..NUM_OPS_PER_KEY).map(move |i| (k, i)))
        .to_stream(scope);
        
    let right = (0..NUM_KEYS)
        .flat_map(|k| (0..NUM_OPS_PER_KEY).map(move |i| (k, i + 100)))
        .to_stream(scope);
        
    left.join(&right)
        .inspect(|(k, (l, r))| {
            black_box((k, l, r));
        });
});
```

### Differential Implementation
```rust
use differential_dataflow::operators::Join;

timely::execute_directly(|worker| {
    let probe = worker.dataflow(|scope| {
        let left = scope.new_collection_from(...).1;
        let right = scope.new_collection_from(...).1;
        
        left.join(&right)
            .inspect(|(k, l, r)| {
                black_box((k, l, r));
            })
            .probe()
    });
    
    worker.step_while(|| probe.less_than(&Default::default()));
});
```

### Hydro Implementation
```rust
dfir_syntax! {
    left = source_iter(...)
        -> map(|k| (k, ()));
        
    right = source_iter(...)
        -> map(|k| (k, ()));
        
    left
        -> [0]my_join;
    right
        -> [1]my_join;
        
    my_join = join()
        -> for_each(|(k, (l, r))| {
            black_box((k, l, r));
        });
}
```

## Performance Analysis

### What to Look For

1. **Throughput**: Items processed per second
   - Higher is better
   - Compare across implementations

2. **Latency**: Time to process single batch
   - Lower is better
   - Check consistency (std deviation)

3. **Overhead**: Compared to baseline
   - Identity benchmark shows framework overhead
   - Gap between raw/iter and framework implementations

4. **Scalability**: How performance changes with:
   - Number of operations (NUM_OPS)
   - Data size (NUM_INTS, NUM_KEYS)
   - Complexity (joins vs. maps)

### Typical Results Pattern

```
identity/raw              fastest    (theoretical minimum)
identity/iter             ~1.1x      (optimized Rust)
identity/timely           ~1.5-2x    (streaming overhead)
identity/dfir_rs          ~1.5-2x    (comparable to timely)
identity/pipeline         slowest    (channel overhead)
```

For joins and complex operations:
- Differential often excels (designed for incremental)
- Timely good for streaming
- Hydro competitive, sometimes faster on certain patterns

## Running Comparisons

### Compare All Implementations
```bash
cargo bench --bench identity
```

Output shows relative performance:
```
identity/raw              time: [12.5 ms 12.6 ms 12.7 ms]
identity/timely           time: [18.2 ms 18.4 ms 18.6 ms]
                          change: [-2.1% +0.3% +2.8%]
identity/dfir_rs          time: [17.9 ms 18.1 ms 18.3 ms]
                          change: [-1.5% +0.1% +1.7%]
```

### Save Baseline
```bash
cargo bench --bench identity -- --save-baseline pre-optimization
# Make changes...
cargo bench --bench identity -- --baseline pre-optimization
```

## Adding New Benchmarks

### Template
```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("my_benchmark/differential", |b| {
        b.iter(|| {
            // Differential implementation
        });
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/dfir_rs", |b| {
        b.iter(|| {
            // Hydro implementation
        });
    });
}

criterion_group!(
    my_benchmark_group,
    benchmark_timely,
    benchmark_differential,
    benchmark_hydroflow,
);
criterion_main!(my_benchmark_group);
```

### Register in Cargo.toml
```toml
[[bench]]
name = "my_benchmark"
harness = false
```

## Best Practices

1. **Use `black_box`**: Prevents compiler from optimizing away work
2. **Consistent Data**: Use same inputs across implementations
3. **Warmup**: Criterion handles this automatically
4. **Multiple Runs**: Default sample size is usually sufficient
5. **Isolate Tests**: Run one benchmark at a time for most accurate results
6. **Document Changes**: Save baselines when making optimizations

## Further Reading

- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Hydro Documentation: See main repository
