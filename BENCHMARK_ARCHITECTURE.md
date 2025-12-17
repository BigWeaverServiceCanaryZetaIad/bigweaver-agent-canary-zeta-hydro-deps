# Benchmark Architecture Documentation

## Overview

This document describes the architecture of the benchmark suite for the BigWeaver Hydro project, which is split across two repositories to enable performance comparison while maintaining clean dependencies.

## Repository Architecture

### Main Repository: bigweaver-agent-canary-hydro-zeta
**Focus**: Hydro-native implementations without external dataflow dependencies

**Contents**:
- Core Hydro/DFIR implementation code
- Hydro-native benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond)
- No timely or differential-dataflow dependencies

**Benefits**:
- Faster build times for core development
- Reduced technical debt from external dependencies
- Clear focus on Hydro-specific functionality

### Dependencies Repository: bigweaver-agent-canary-zeta-hydro-deps (This Repository)
**Focus**: Comparative benchmarks with multiple dataflow implementations

**Contents**:
- Benchmarks comparing Timely/Differential-Dataflow with Hydro implementations
- All timely and differential-dataflow dependencies
- Git dependencies on dfir_rs and sinktools from main repository

**Benefits**:
- Maintains performance comparison capabilities
- Isolated dependency footprint
- Reference implementations for validation

## Benchmark Design Pattern

Each benchmark in this repository follows a consistent pattern with multiple implementations:

### 1. Timely/Differential-Dataflow Implementation
```rust
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("operation/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                // Timely dataflow implementation
            });
        })
    });
}
```

**Purpose**: Baseline performance from established dataflow framework

### 2. Hydro (dfir_rs) Implementations

#### Surface Syntax (High-Level)
```rust
fn benchmark_hydroflow_surface(c: &mut Criterion) {
    c.bench_function("operation/dfir_rs/surface", |b| {
        b.iter_batched(
            || {
                dfir_syntax! {
                    // High-level Hydro syntax
                }
            },
            |mut df| {
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}
```

**Purpose**: Performance of user-facing Hydro API

#### Compiled/SinkBuilder (Mid-Level)
```rust
fn benchmark_hydroflow_compiled(c: &mut Criterion) {
    c.bench_function("operation/dfir_rs/compiled", |b| {
        b.to_async(runtime).iter(|| async {
            let sink = SinkBuilder::<T>::new()
                .map(|x| x + 1)
                // ... operations ...
                .for_each(|x| { black_box(x); });
            // Execute pipeline
        });
    });
}
```

**Purpose**: Performance of compiled Hydro operators

### 3. Baseline Implementations

#### Raw Rust
```rust
fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("operation/raw", |b| {
        b.iter(|| {
            // Direct Rust implementation
        })
    });
}
```

**Purpose**: Best-case performance ceiling

#### Pipeline (Multi-threaded)
```rust
fn benchmark_pipeline(c: &mut Criterion) {
    c.bench_function("operation/pipeline", |b| {
        b.iter(|| {
            // Channel-based pipeline
        })
    });
}
```

**Purpose**: Multi-threaded baseline performance

## Benchmark Categories

### Data Flow Patterns

#### Fan-Out (`fan_out.rs`)
Tests the ability to split a single input stream into multiple output streams.

**Pattern**: 1 → N
**Key Operations**: tee, branch, split

#### Fan-In (`fan_in.rs`)
Tests the ability to merge multiple input streams into a single output.

**Pattern**: N → 1
**Key Operations**: union, merge, concat

#### Fork-Join (`fork_join.rs`)
Tests parallel processing with merge pattern (split, process, merge).

**Pattern**: 1 → N → Process → N → 1
**Special**: Generated code for parameterized operation count

### Operations

#### Arithmetic (`arithmetic.rs`)
Tests sequential transformations (20 map operations).

**Focus**: Operator overhead, pipeline efficiency
**Operations**: map, transform chains

#### Identity (`identity.rs`)
Tests passthrough operations to measure framework overhead.

**Focus**: Minimal overhead baseline
**Operations**: identity transformations

#### Join (`join.rs`)
Tests relational join operations.

**Focus**: Relational operations, state management
**Operations**: join, cross product

### Domain-Specific

#### Reachability (`reachability.rs`)
Graph traversal benchmark with real test data.

**Data Files**:
- `reachability_edges.txt` - Graph edges
- `reachability_reachable.txt` - Expected reachable nodes

**Focus**: Iterative computation, graph algorithms
**Operations**: iterate, join, recursive queries

#### Upcase (`upcase.rs`)
String transformation benchmark.

**Focus**: Text processing, map operations
**Operations**: map with string operations

## Performance Comparison Workflow

### Step 1: Run Comparative Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

This produces:
- Timely/Differential-Dataflow baselines
- Hydro comparative implementations
- Raw Rust baselines

### Step 2: Run Hydro-Native Benchmarks
```bash
cd bigweaver-agent-canary-hydro-zeta/benches
cargo bench
```

This produces:
- Pure Hydro implementation benchmarks
- Advanced Hydro-specific patterns

### Step 3: Analyze Results
Results are stored in `target/criterion/` with:
- HTML reports for visualization
- Statistical analysis (mean, median, std dev)
- Regression detection
- Performance trends over time

### Step 4: Interpret Comparisons

**Expected Patterns**:
- Raw Rust: Fastest (best-case ceiling)
- Timely: Established framework baseline
- Hydro: Competitive with timely, goal is to match or exceed

**Key Metrics**:
- Throughput (operations/second)
- Latency (time per operation)
- Overhead (vs raw baseline)
- Scalability (performance with data size)

## Build System Integration

### Build Script (`build.rs`)
Generates code for parameterized benchmarks.

**Example**: `fork_join.rs` benchmark
- Generates `fork_join_20.hf` with 20 operations
- Included at compile time
- Allows consistent operation count across implementations

### Dependencies

#### Git Dependencies
```toml
dfir_rs = { git = "https://github.com/.../bigweaver-agent-canary-hydro-zeta.git" }
sinktools = { git = "https://github.com/.../bigweaver-agent-canary-hydro-zeta.git" }
```

**Rationale**: 
- Not published to crates.io
- Internal development packages
- Always uses latest from main repository

#### Package Dependencies
```toml
timely = { package = "timely-master", version = "0.13.0-dev.1" }
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

**Rationale**: Specific dev versions for consistency

## Usage Guidelines

### Running All Benchmarks
```bash
cargo bench -p benches
```

### Running Specific Benchmarks
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench reachability
```

### Running Specific Implementations
```bash
# Only timely implementations
cargo bench -p benches --bench arithmetic timely

# Only Hydro implementations  
cargo bench -p benches --bench arithmetic dfir_rs

# Only raw baselines
cargo bench -p benches --bench arithmetic raw
```

### Comparing Specific Patterns
```bash
# Compare all fan-out implementations
cargo bench -p benches --bench fan_out

# Compare all join implementations
cargo bench -p benches --bench join
```

## Maintenance

### Adding New Benchmarks

1. **Create benchmark file** in `benches/benches/`
2. **Implement multiple versions**: timely, dfir_rs, raw
3. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "new_benchmark"
   harness = false
   ```
4. **Update documentation**: README.md, this file
5. **Add test data** if needed

### Updating Dependencies

1. **Update Cargo.toml** versions
2. **Test all benchmarks** compile and run
3. **Check for API changes** in implementations
4. **Update documentation** if behavior changes

### Performance Regression Detection

Criterion automatically detects regressions:
- Compares against previous runs
- Statistical significance testing
- Highlights performance changes
- Stores historical data

## Troubleshooting

### Build Errors

**Problem**: Cannot find dfir_rs or sinktools
**Solution**: Ensure git dependencies are accessible, check network

**Problem**: Timely/differential-dataflow not found
**Solution**: Check package registry, verify version availability

### Benchmark Failures

**Problem**: Benchmark times out
**Solution**: Reduce data size constants (NUM_INTS, NUM_OPS)

**Problem**: Inconsistent results
**Solution**: Ensure no background processes, run multiple times

### Dependency Issues

**Problem**: Git dependency conflicts
**Solution**: Use specific commit or tag in Cargo.toml:
```toml
dfir_rs = { git = "...", rev = "abc123" }
```

## References

- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
