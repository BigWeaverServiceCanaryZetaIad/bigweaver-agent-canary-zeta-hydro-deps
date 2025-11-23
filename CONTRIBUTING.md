# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro performance benchmarks! This guide will help you add new benchmarks or improve existing ones.

## Quick Start for Contributors

1. Fork the repository
2. Create a feature branch
3. Add or modify benchmarks
4. Run verification: `./verify_benchmarks.sh`
5. Run benchmarks: `cargo bench`
6. Submit a pull request

## Adding a New Benchmark

### 1. Create the Benchmark File

Create a new file in `benches/your_benchmark.rs`:

```rust
use criterion::{Criterion, criterion_group, criterion_main, black_box};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Inspect};

// Configure workload size
const DATA_SIZE: usize = 1_000_000;

fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("your_benchmark/baseline", |b| {
        b.iter(|| {
            // Your baseline implementation
            let data: Vec<_> = (0..DATA_SIZE).collect();
            for item in data {
                black_box(item);
            }
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                // Your Timely implementation
                (0..DATA_SIZE).to_stream(worker)
                    .inspect(|x| { black_box(x); });
            });
        });
    });
}

fn benchmark_dfir(c: &mut Criterion) {
    c.bench_function("your_benchmark/dfir", |b| {
        b.iter(|| {
            let mut flow = dfir_rs::dfir_syntax! {
                // Your DFIR implementation
                source_iter(0..DATA_SIZE)
                    -> for_each(|x| { black_box(x); });
            };
            flow.run_available();
        });
    });
}

criterion_group!(
    benches,
    benchmark_baseline,
    benchmark_timely,
    benchmark_dfir
);
criterion_main!(benches);
```

### 2. Register in Cargo.toml

Add to `Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

### 3. Test Your Benchmark

```bash
# Check compilation
cargo check --bench your_benchmark

# Run in quick mode
cargo bench --bench your_benchmark -- --quick

# Run full benchmark
cargo bench --bench your_benchmark
```

### 4. Document Your Benchmark

Update documentation:

- Add description to `README.md` (Benchmarks section)
- Add detailed guide to `BENCHMARKS.md`
- Include comments in the benchmark code explaining what it measures

## Benchmark Best Practices

### Structure

✅ **DO**:
- Include multiple implementations (baseline, timely, dfir)
- Use consistent naming: `benchmark_name/implementation`
- Use `black_box()` to prevent compiler optimizations
- Include verification where appropriate
- Document what you're measuring and why

❌ **DON'T**:
- Mix different workload types in one benchmark
- Use I/O operations without careful consideration
- Create benchmarks that take hours to run
- Forget to document configuration constants

### Performance

```rust
// Good: Clear, measurable workload
const NUM_ITEMS: usize = 1_000_000;
const NUM_ITERATIONS: usize = 10;

// Bad: Magic numbers
for i in 0..12345 {  // What does 12345 represent?
    // ...
}
```

### Verification

Include output verification for complex benchmarks:

```rust
fn verify_results(result: &[i32], expected: &[i32]) {
    assert_eq!(result.len(), expected.len());
    assert_eq!(result, expected);
}
```

### Data Files

If your benchmark needs data files:

1. Keep files reasonably sized (< 10 MB if possible)
2. Use binary formats for large datasets
3. Include files in `benches/` directory
4. Document file format and source
5. Add to `.gitignore` if generated

Example:
```rust
static DATA: LazyLock<Vec<u8>> = LazyLock::new(|| {
    include_bytes!("benchmark_data.bin").to_vec()
});
```

## Code Style

### Follow Rust Conventions

- Use `rustfmt`: `cargo fmt`
- Pass `clippy`: `cargo clippy --benches`
- Follow naming conventions

### Benchmark Naming

```rust
// Pattern: benchmark_category/implementation
c.bench_function("dataflow_ops/pipeline", ...);
c.bench_function("dataflow_ops/timely", ...);
c.bench_function("dataflow_ops/dfir", ...);
```

### Comments

```rust
// Good: Explains the purpose
// This benchmark measures join performance with different key distributions.
// We test uniform keys (worst case) vs. skewed keys (more realistic).

// Bad: States the obvious
// This is a benchmark
```

## Testing

Before submitting:

```bash
# 1. Format code
cargo fmt

# 2. Check for warnings
cargo clippy --benches

# 3. Verify compilation
cargo check --benches

# 4. Run verification script
./verify_benchmarks.sh

# 5. Run your benchmark
cargo bench --bench your_benchmark

# 6. Check results make sense
open target/criterion/your_benchmark/report/index.html
```

## Pull Request Process

### 1. Branch Naming

Follow the pattern: `add-<benchmark-name>-benchmark`

Example:
```bash
git checkout -b add-pagerank-benchmark
```

### 2. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(benchmarks): add PageRank benchmark

- Implements baseline, timely, and dfir versions
- Includes test graph data (10K nodes)
- Compares iterative computation performance
```

### 3. PR Title

Format: `feat(benchmarks): add <benchmark-name> benchmark`

Examples:
- `feat(benchmarks): add PageRank benchmark`
- `fix(benchmarks): correct reachability data loading`
- `docs(benchmarks): improve arithmetic benchmark documentation`

### 4. PR Description

Include:

```markdown
## Overview
Brief description of what the benchmark measures.

## Changes Made
- ✅ Added benchmark file: `benches/your_benchmark.rs`
- ✅ Updated `Cargo.toml` with benchmark entry
- ✅ Added test data files (if applicable)
- ✅ Updated documentation

## Benchmark Results
Include sample results showing performance comparison.

## Testing
- [x] Benchmark compiles
- [x] Benchmark runs successfully
- [x] Verification script passes
- [x] Results are reasonable
```

## Dependencies

### Adding Dependencies

Only add dependencies if necessary. Prefer:
- Using existing dependencies
- Lightweight alternatives
- Optional features

If adding a dependency:

```toml
[dev-dependencies]
new-crate = { version = "1.0", optional = true }
```

Document why it's needed in the PR description.

### Updating Dependencies

```bash
# Update specific dependency
cargo update -p dependency-name

# Update all dependencies
cargo update
```

## Documentation

### Code Documentation

```rust
/// Benchmark for measuring symmetric hash join performance.
///
/// This benchmark tests join operations with:
/// - Different dataset sizes (1K, 10K, 100K, 1M)
/// - Different key distributions (uniform, zipf, normal)
/// - Different join selectivity (1:1, 1:N, N:M)
///
/// Results help identify optimal join strategies for different workloads.
fn benchmark_symmetric_hash_join(c: &mut Criterion) {
    // Implementation...
}
```

### README Updates

When adding a benchmark, update `README.md`:

```markdown
### Your Benchmark Category

- **`your_benchmark.rs`** - Brief description
  - What it tests
  - Key measurements
  - When it's useful
```

### Detailed Documentation

Add to `BENCHMARKS.md`:

```markdown
#### Your Benchmark Name (`your_benchmark.rs`)
**Purpose**: Detailed description of what this measures.

**Operation**: Explain the workload.

**Variants**:
- `your_benchmark/baseline` - Description
- `your_benchmark/timely` - Description
- `your_benchmark/dfir` - Description

**Run**:
```bash
cargo bench --bench your_benchmark
```

**Key Metrics**: What to look for in results.
```

## Common Patterns

### Iteration Pattern

```rust
// Differential dataflow iteration
worker.dataflow::<usize, _, _>(|scope| {
    let (handle, stream) = scope.new_collection();
    
    let result = stream.iterate(|inner| {
        // Iterative computation
        inner.map(|x| x + 1)
            .filter(|x| *x < 100)
    });
    
    result.inspect(|x| { black_box(x); });
    handle
});
```

### Stream Processing Pattern

```rust
// Timely dataflow
timely::execute_directly(|worker| {
    worker.dataflow::<(), _, _>(|scope| {
        (0..NUM_ITEMS)
            .to_stream(scope)
            .map(|x| x * 2)
            .filter(|x| x % 2 == 0)
            .inspect(|x| { black_box(x); });
    });
});
```

### DFIR Pattern

```rust
// DFIR
let mut flow = dfir_rs::dfir_syntax! {
    source_iter(0..NUM_ITEMS)
        -> map(|x| x * 2)
        -> filter(|x| x % 2 == 0)
        -> for_each(|x| { black_box(x); });
};
flow.run_available();
```

## Questions?

- Check [README.md](README.md) for overview
- Read [BENCHMARKS.md](BENCHMARKS.md) for detailed info
- Review existing benchmarks in `benches/`
- See [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)
- Check [main Hydro repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.
