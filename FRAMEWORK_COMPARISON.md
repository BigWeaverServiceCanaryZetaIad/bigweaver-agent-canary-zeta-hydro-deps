# Framework Comparison Guide

This document provides a detailed comparison of Timely Dataflow, Differential Dataflow, and Hydroflow, helping you understand when to use each framework and how to interpret benchmark results.

## Framework Overview

### Timely Dataflow

**Philosophy**: Low-level dataflow coordination with explicit control over timing and coordination.

**Key Features**:
- Fine-grained timestamp control
- Explicit progress tracking
- Flexible dataflow construction
- Worker-based parallelism

**Best For**:
- Custom coordination patterns
- Complex distributed algorithms
- When you need low-level control
- Research prototyping

**Trade-offs**:
- More verbose code
- Steeper learning curve
- Manual state management

### Differential Dataflow

**Philosophy**: Incremental computation with automatic change propagation.

**Key Features**:
- Automatic incrementalization
- Collection-based API
- Built on Timely Dataflow
- Efficient incremental updates

**Best For**:
- Incremental computations
- Iterative algorithms
- Dynamic datasets
- Materialized views

**Trade-offs**:
- Memory overhead for maintaining state
- Complexity for simple one-shot queries
- Learning the collection operators

### Hydroflow

**Philosophy**: Modern dataflow with multiple programming models optimized for common patterns.

**Key Features**:
- Multiple APIs (compiled, scheduled, surface)
- Surface syntax for ergonomics
- Optimized for common patterns
- Good balance of control and ease

**Best For**:
- Application development
- Standard dataflow patterns
- When ergonomics matter
- Distributed systems

**Trade-offs**:
- Newer ecosystem
- Different mental model per API
- Still evolving

## API Comparison

### Identity/Map Operations

#### Timely Dataflow
```rust
timely::example(|scope| {
    (0..1000)
        .to_stream(scope)
        .map(|x| x * 2)
        .map(|x| x + 1)
        .inspect(|x| println!("{}", x));
});
```

#### Differential Dataflow
```rust
timely::execute_directly(|worker| {
    worker.dataflow::<u32, _, _>(|scope| {
        scope.new_collection_from(0..1000).1
            .map(|x| x * 2)
            .map(|x| x + 1)
            .inspect(|x| println!("{}", x));
    });
});
```

#### Hydroflow (Surface Syntax)
```rust
let mut df = dfir_syntax! {
    source_iter(0..1000)
    -> map(|x| x * 2)
    -> map(|x| x + 1)
    -> for_each(|x| println!("{}", x));
};
df.run_available_sync();
```

**Comparison**:
- **Verbosity**: Hydroflow < Differential < Timely
- **Explicitness**: Timely > Differential > Hydroflow
- **Learning Curve**: Hydroflow < Differential < Timely

### Join Operations

#### Timely Dataflow
```rust
lhs_stream.binary(&rhs_stream, Pipeline, Pipeline, "Join", |_, _| {
    let mut left_state: HashMap<K, Vec<L>> = HashMap::new();
    let mut right_state: HashMap<K, Vec<R>> = HashMap::new();
    
    move |left, right, output| {
        // Manual join logic with state management
        // Process left input
        left.for_each(|time, data| {
            let mut session = output.session(&time);
            for (k, l) in data.iter().cloned() {
                if let Some(rs) = right_state.get(&k) {
                    for r in rs {
                        session.give((k, l.clone(), r.clone()));
                    }
                }
                left_state.entry(k).or_default().push(l);
            }
        });
        // Process right input...
    }
})
```

#### Differential Dataflow
```rust
let joined = collection1.join(&collection2);
```

#### Hydroflow (Surface Syntax)
```rust
dfir_syntax! {
    lhs = source_iter(lhs_data);
    rhs = source_iter(rhs_data);
    joined = join();
    lhs -> [0]joined;
    rhs -> [1]joined;
    joined -> output;
}
```

**Comparison**:
- **Lines of Code**: Differential (1) < Hydroflow (6) << Timely (20+)
- **Control**: Timely (full) > Hydroflow (medium) > Differential (automatic)
- **Performance**: Similar for standard joins

### Iteration/Fixed-Point

#### Timely Dataflow
```rust
let (handle, cycle) = scope.feedback(1);
let initial = roots.to_stream(scope);
let reachable = scope.concatenate(vec![initial, cycle]);

let next = reachable.unary_notify(Pipeline, "step", None, move |input, output, _| {
    // Manual iteration logic
});

next.connect_loop(handle);
```

#### Differential Dataflow
```rust
let reachable = roots.iterate(|reach| {
    edges
        .enter(&reach.scope())
        .semijoin(reach)
        .map(|(_src, dst)| dst)
        .concat(reach)
        .distinct()
});
```

#### Hydroflow
```rust
dfir_syntax! {
    origin = source_iter([root]);
    reached = union();
    origin -> reached;
    
    reached 
        -> filter_map(|v| edges.get(&v))
        -> flatten()
        -> filter(|v| seen.insert(*v))
        -> reached;
}
```

**Comparison**:
- **Abstraction Level**: Differential (high) > Hydroflow (medium) > Timely (low)
- **Fixed-Point Detection**: Differential (automatic) > Hydroflow (manual) = Timely (manual)
- **Flexibility**: Timely > Hydroflow > Differential

## Performance Characteristics

### Throughput

| Framework      | Identity | Join  | Iteration | Notes                    |
|---------------|----------|-------|-----------|--------------------------|
| Timely        | Good     | Good  | Good      | Consistent performance   |
| Differential  | Good     | Good  | Excellent | Shines with incremental  |
| Hydroflow     | Excellent| Good  | Good      | Optimized for common ops |
| Baseline      | Excellent| Fair  | Good      | Reference point          |

### Memory Usage

| Framework      | Overhead | State Management | Notes                      |
|---------------|----------|------------------|----------------------------|
| Timely        | Low      | Manual           | Pay for what you use       |
| Differential  | High     | Automatic        | Maintains full history     |
| Hydroflow     | Medium   | Semi-automatic   | Optimized for common cases |

### Startup Latency

| Framework      | Startup Time | Notes                        |
|---------------|--------------|------------------------------|
| Timely        | Fast         | Minimal initialization       |
| Differential  | Medium       | Collection setup overhead    |
| Hydroflow     | Varies       | Depends on API used          |

## Use Case Recommendations

### Choose Timely Dataflow When:

✅ You need fine-grained control over timing
✅ Building custom coordination protocols
✅ Implementing research algorithms
✅ Performance critical low-level operations
✅ Working with complex timestamp domains

Example Scenarios:
- Custom distributed consensus
- Specialized streaming algorithms
- Research prototypes
- Educational purposes

### Choose Differential Dataflow When:

✅ Data changes incrementally
✅ Need to maintain multiple queries
✅ Iterative graph algorithms
✅ Implementing datalog-style queries
✅ Building materialized views

Example Scenarios:
- Incremental graph analytics
- Real-time analytics dashboards
- Dynamic query evaluation
- Streaming joins with updates
- Datalog engine implementation

### Choose Hydroflow When:

✅ Building distributed applications
✅ Standard dataflow patterns
✅ Ergonomics and productivity matter
✅ Want multiple programming models
✅ Need good documentation and support

Example Scenarios:
- Distributed system applications
- Stream processing pipelines
- Real-time data processing
- Microservice coordination
- Production applications

## Benchmark Interpretation

### Single-Query Benchmarks

Our benchmarks primarily measure single-query, one-shot performance. This favors:

1. **Baseline implementations**: Specialized for specific case
2. **Hydroflow**: Optimized for common patterns
3. **Timely**: Good all-around performance
4. **Differential**: Overhead from generality

**Important**: Single-query benchmarks don't show Differential's true strengths!

### Where Differential Excels

Differential Dataflow's benefits appear with:

1. **Incremental Updates**: New data arrives, queries update efficiently
2. **Multiple Queries**: Same data, many queries
3. **Iterative Refinement**: Fixed-point with changing data

Example: 10 queries on changing data
- **One-shot**: Differential = 10x baseline
- **Incremental**: Differential = 1.5x baseline (huge real speedup)

### Framework Overhead

Measure framework overhead:
```
Overhead = (Framework_Time - Baseline_Time) / Baseline_Time
```

Expected overhead ranges:
- **Timely**: 10-30% for simple operations
- **Differential**: 20-50% for one-shot queries
- **Hydroflow**: 5-20% for optimized patterns

### When Performance Differs from Expectations

**Timely slower than expected**:
- Check timestamp handling
- Verify coordination is necessary
- Consider barrier overhead

**Differential slower than expected**:
- Single-query case (expected)
- Check collection size
- Consider arrangement overhead

**Hydroflow slower than expected**:
- Check API choice (compiled vs scheduled)
- Verify optimization level
- Consider operator choice

## Code Complexity Comparison

### Lines of Code for Common Patterns

| Pattern      | Timely | Differential | Hydroflow |
|-------------|--------|--------------|-----------|
| Map         | 5      | 3            | 2         |
| Filter      | 5      | 3            | 2         |
| Join        | 30+    | 1            | 6         |
| Iteration   | 20+    | 10           | 12        |
| Aggregation | 25+    | 5            | 8         |

### Learning Curve

**Timely Dataflow**:
- Initial: Steep (need to understand timely computation model)
- Advanced: Medium (concepts transfer from theory)
- Mastery: Requires deep understanding

**Differential Dataflow**:
- Initial: Medium (collection operators familiar)
- Advanced: Steep (understanding incrementalization)
- Mastery: Requires theoretical knowledge

**Hydroflow**:
- Initial: Gentle (surface syntax intuitive)
- Advanced: Medium (multiple APIs to learn)
- Mastery: Growing ecosystem

## Migration Guide

### From Timely to Hydroflow

**Simple patterns**: Usually straightforward
```rust
// Timely
stream.map(f)

// Hydroflow
-> map(f)
```

**State management**: More automatic in Hydroflow
```rust
// Timely: Manual state
let state_handle = df.add_state(State::new());

// Hydroflow: Captured in closure
-> filter(|x| seen.insert(*x))
```

### From Differential to Hydroflow

**Collections become streams**:
```rust
// Differential
collection.map(f)

// Hydroflow
-> map(f)
```

**Iteration**: More explicit in Hydroflow
```rust
// Differential: Automatic
roots.iterate(|x| ...)

// Hydroflow: Feedback explicit
-> feedback_loop
```

## Conclusion

### Summary Table

| Aspect           | Timely | Differential | Hydroflow |
|-----------------|--------|--------------|-----------|
| **Ease of Use** | ⭐⭐   | ⭐⭐⭐       | ⭐⭐⭐⭐   |
| **Performance** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐     | ⭐⭐⭐⭐   |
| **Flexibility** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐     | ⭐⭐⭐⭐   |
| **Incremental** | ⭐⭐   | ⭐⭐⭐⭐⭐   | ⭐⭐⭐    |
| **Learning**    | ⭐⭐   | ⭐⭐⭐       | ⭐⭐⭐⭐   |
| **Maturity**    | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐   | ⭐⭐⭐    |

### Best Practices for Comparison

1. **Use multiple benchmarks**: Don't rely on single measurement
2. **Consider use case**: Match benchmark to your scenario
3. **Look at trends**: Relative performance matters
4. **Test incremental**: If using Differential, test with updates
5. **Profile real workload**: Synthetic benchmarks are starting point

### Further Resources

- [Naiad Paper](https://dl.acm.org/doi/10.1145/2517349.2522738) - Timely foundations
- [Differential Dataflow Paper](https://github.com/TimelyDataflow/differential-dataflow/blob/master/differentialdataflow.pdf)
- [Hydroflow Documentation](https://hydro.run/)
- Main repository: [BENCHMARK_COMPARISON_ARCHIVE.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_COMPARISON_ARCHIVE.md)
