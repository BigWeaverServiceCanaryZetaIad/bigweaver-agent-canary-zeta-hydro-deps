# Development Guide

## Repository Setup

This repository contains performance comparison benchmarks between Hydro and other dataflow systems (timely, differential-dataflow).

### Prerequisites

1. **Rust toolchain**: Install via rustup
2. **Main Hydro repository**: Must be checked out at `../bigweaver-agent-canary-hydro-zeta`

### Directory Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/           # Benchmark implementations
│   ├── Cargo.toml         # Benchmark dependencies
│   ├── build.rs           # Build-time code generation
│   └── README.md          # Benchmark documentation
├── Cargo.toml             # Workspace configuration
├── README.md              # Repository overview
└── DEVELOPMENT.md         # This file
```

## Building

### Build All Benchmarks

```bash
cargo build --release
```

### Build Specific Benchmark

```bash
cargo build --release --bench reachability
```

## Running Benchmarks

### Quick Test (Debug Mode)

```bash
# Run a specific benchmark in debug mode for quick testing
cargo bench --bench arithmetic -- --test
```

### Full Benchmark Run

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run benchmark with specific filter
cargo bench --bench join -- "join/vec"
```

### Viewing Results

Benchmark results are stored in HTML format:
```bash
# Open in browser
open target/criterion/report/index.html
```

## Understanding the Benchmarks

### Benchmark Patterns

Each benchmark typically includes multiple implementations:

1. **Hydro (dfir_rs)**: 
   - Surface syntax (using dfir_syntax! macro)
   - Compiled (using SinkBuilder)
   - Various optimizations

2. **Timely Dataflow**: Direct timely implementation

3. **Differential Dataflow**: Where applicable (e.g., reachability)

4. **Baseline**: Often includes pure Rust implementations for comparison

### Example Structure

```rust
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("benchmark_name/hydroflow", |b| {
        // Hydro implementation
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("benchmark_name/timely", |b| {
        // Timely implementation
    });
}

criterion_group!(benchmarks, benchmark_hydroflow, benchmark_timely);
criterion_main!(benchmarks);
```

## Adding New Benchmarks

### 1. Create Benchmark File

Create a new file in `benches/benches/`:

```bash
touch benches/benches/my_benchmark.rs
```

### 2. Implement Benchmark

```rust
use criterion::{Criterion, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::*;

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydroflow", |b| {
        b.iter(|| {
            // Your Hydro implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            // Your Timely implementation
        });
    });
}

criterion_group!(my_benchmarks, benchmark_hydroflow, benchmark_timely);
criterion_main!(my_benchmarks);
```

### 3. Register in Cargo.toml

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

### 4. Test the Benchmark

```bash
cargo bench --bench my_benchmark
```

## Debugging

### Debug Build

```bash
cargo build --benches
```

### Add Debug Output

Use `eprintln!` for debug output (won't interfere with criterion):

```rust
fn benchmark_hydroflow(c: &mut Criterion) {
    eprintln!("Debug: Starting benchmark");
    c.bench_function("test", |b| {
        // ...
    });
}
```

### Check Generated Code

For benchmarks using `build.rs`:

```bash
cargo clean
cargo build --benches --verbose
```

Check generated files in build output directory.

## Performance Tips

### Optimization Levels

Benchmarks should always run in release mode:
```bash
cargo bench  # Automatically uses release mode
```

### Reducing Noise

1. **Close other applications**: Minimize background processes
2. **Disable CPU frequency scaling**: For consistent results
3. **Multiple runs**: Criterion automatically does this
4. **Baseline comparisons**: Use criterion's baseline feature

```bash
# Save baseline
cargo bench -- --save-baseline master

# Compare against baseline
cargo bench -- --baseline master
```

### Profiling

To profile a specific benchmark:

```bash
# Using perf (Linux)
cargo bench --bench reachability --profile=profile -- --profile-time=5
perf record -g target/release/deps/reachability-*
perf report

# Using flamegraph
cargo install flamegraph
cargo flamegraph --bench reachability
```

## Dependencies

### Main Dependencies

- **criterion**: Benchmarking framework
- **timely-master**: Timely Dataflow (dev version)
- **differential-dataflow-master**: Differential Dataflow (dev version)

### Cross-Repository Dependencies

From main Hydro repository:
- **dfir_rs**: Core Hydro implementation
- **sinktools**: Hydro utilities

### Updating Dependencies

```bash
# Update all dependencies
cargo update

# Update specific dependency
cargo update -p timely-master

# Check outdated dependencies
cargo outdated
```

## Testing Strategy

### Quick Smoke Test

```bash
# Test all benchmarks quickly (1 sample, short time)
cargo bench -- --test
```

### Full Regression Test

```bash
# Save baseline before changes
cargo bench -- --save-baseline before

# Make your changes...

# Compare after changes
cargo bench -- --baseline before
```

### CI Integration

Example GitHub Actions workflow:

```yaml
name: Benchmarks

on: [pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Checkout main repo
        uses: actions/checkout@v2
        with:
          repository: hydro-project/hydro
          path: bigweaver-agent-canary-hydro-zeta
      - name: Run benchmarks
        run: cargo bench -- --test
```

## Common Issues

### "Cannot find dfir_rs"

**Problem**: Main repository not at expected location

**Solution**: 
```bash
# Ensure main repo is checked out
cd ..
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### "Benchmark takes too long"

**Problem**: Benchmark parameters too large

**Solution**: Adjust constants in benchmark file:
```rust
// Before
const NUM_ITEMS: usize = 1_000_000;

// After
const NUM_ITEMS: usize = 100_000;
```

### "Inconsistent results"

**Problem**: System noise or thermal throttling

**Solution**:
1. Close background applications
2. Wait for system to cool down
3. Use longer sample times
4. Run multiple iterations

## Code Style

### Formatting

```bash
cargo fmt
```

### Linting

```bash
cargo clippy --all-targets
```

### Documentation

Add documentation comments to benchmark functions:

```rust
/// Benchmarks Hydro's join operation with vector-based data.
/// 
/// Tests the performance of joining two streams where data is stored
/// in vectors and accessed via iteration.
fn benchmark_join_vec(c: &mut Criterion) {
    // ...
}
```

## Contribution Guidelines

1. **Add benchmarks for new features**: When adding comparisons
2. **Document performance characteristics**: Explain what's being tested
3. **Include multiple implementations**: Hydro, timely, baseline
4. **Keep benchmarks focused**: One concept per benchmark file
5. **Use realistic data**: Mirror real-world usage patterns

## Resources

- **Criterion.rs**: https://bheisler.github.io/criterion.rs/book/
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow
- **Hydro Documentation**: See main repository
