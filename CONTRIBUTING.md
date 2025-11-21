# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydroflow benchmarks repository! This document provides guidelines for contributing new benchmarks or improving existing ones.

## Table of Contents

- [Getting Started](#getting-started)
- [Adding New Benchmarks](#adding-new-benchmarks)
- [Benchmark Guidelines](#benchmark-guidelines)
- [Testing Your Benchmarks](#testing-your-benchmarks)
- [Documentation](#documentation)
- [Code Style](#code-style)
- [Submitting Changes](#submitting-changes)

## Getting Started

### Prerequisites

- Rust toolchain (latest stable)
- Git
- Familiarity with Criterion.rs
- Understanding of Hydroflow, Timely, and/or Differential Dataflow

### Setup

1. Clone the repository:
```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. Build the project:
```bash
cargo build -p hydro-timely-differential-benchmarks
```

3. Run existing benchmarks to verify setup:
```bash
cargo bench -p hydro-timely-differential-benchmarks --bench identity -- --sample-size 10
```

## Adding New Benchmarks

### Step 1: Create Benchmark File

Create a new file in `benches/benches/your_benchmark_name.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use dfir_rs::scheduled::graph_ext::GraphExt;
use timely::dataflow::operators::*;

// Constants for benchmark parameters
const DATASET_SIZE: usize = 10_000;
const NUM_ITERATIONS: usize = 100;

/// Hydroflow implementation
fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("your_operation/hydroflow", |b| {
        b.iter_batched(
            || {
                // Setup code (not timed)
                dfir_syntax! {
                    source_iter(0..DATASET_SIZE)
                        -> map(|x| x * 2)
                        -> for_each(|x| { black_box(x); });
                }
            },
            |mut df| {
                // Timed code
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}

/// Timely Dataflow implementation
fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("your_operation/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..DATASET_SIZE)
                    .to_stream(scope)
                    .map(|x| black_box(x * 2))
                    .inspect(|x| { black_box(x); });
            });
        })
    });
}

/// Differential Dataflow implementation (if applicable)
fn benchmark_differential(c: &mut Criterion) {
    use differential_dataflow::input::Input;
    
    c.bench_function("your_operation/differential", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                let (mut input, probe) = worker.dataflow::<usize, _, _>(|scope| {
                    let (input_handle, data) = scope.new_collection();
                    
                    let result = data.map(|x| x * 2);
                    
                    (input_handle, result.probe())
                });
                
                for i in 0..DATASET_SIZE {
                    input.insert(i);
                }
                input.advance_to(1);
                input.flush();
                
                worker.step_while(|| probe.less_than(input.time()));
            });
        })
    });
}

// Register all benchmarks
criterion_group!(
    benches, 
    benchmark_hydroflow, 
    benchmark_timely,
    benchmark_differential
);
criterion_main!(benches);
```

### Step 2: Update Cargo.toml

Add your benchmark to `benches/Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark_name"
harness = false
```

### Step 3: Add Documentation

Add your benchmark to the table in `benches/README.md`:

```markdown
| `your_benchmark_name` | Description of what it tests | Hydroflow, Timely, Differential |
```

## Benchmark Guidelines

### What Makes a Good Benchmark?

1. **Focused** - Test one specific operation or pattern
2. **Representative** - Use realistic data sizes and patterns
3. **Comparable** - Implement equivalent logic across frameworks
4. **Documented** - Clear comments explaining what's being tested
5. **Consistent** - Use similar setup and measurement patterns

### Benchmark Categories

Consider which category your benchmark fits:

- **Basic Operations** - Fundamental operations (map, filter, fold)
- **Control Flow** - Patterns like fan-in, fan-out, fork-join
- **Data Operations** - Joins, aggregations, windows
- **I/O Operations** - Reading/writing data
- **Complex Patterns** - Multi-stage pipelines, iterative algorithms

### Performance Considerations

1. **Use `black_box`** - Prevent compiler optimizations from skewing results:
   ```rust
   use criterion::black_box;
   for_each(|x| { black_box(x); });
   ```

2. **Separate Setup from Measurement** - Use `iter_batched` for setup code:
   ```rust
   b.iter_batched(
       || setup_data(),  // Not timed
       |data| process(data),  // Timed
       criterion::BatchSize::SmallInput,
   )
   ```

3. **Choose Appropriate Dataset Sizes** - Balance between:
   - Too small: Measurement noise dominates
   - Too large: Benchmarks take too long
   - Typical range: 1,000 - 1,000,000 elements

4. **Consider Memory Usage** - Large datasets should be generated, not stored

### Common Patterns

#### Simple Transformation
```rust
// Hydroflow
dfir_syntax! {
    source_iter(data) -> map(|x| transform(x)) -> for_each(|x| { black_box(x); });
}

// Timely
data.to_stream(scope).map(|x| transform(x)).inspect(|x| { black_box(x); });
```

#### Join Operation
```rust
// Hydroflow
dfir_syntax! {
    lhs = source_iter(left_data) -> [0]joined;
    rhs = source_iter(right_data) -> [1]joined;
    joined = join() -> for_each(|(k, (l, r))| { black_box((k, l, r)); });
}

// Differential
let left_collection = scope.new_collection_from(left_data).1;
let right_collection = scope.new_collection_from(right_data).1;
let joined = left_collection.join(&right_collection);
```

#### Iterative Computation
```rust
// Differential (best for iterative)
use differential_dataflow::operators::Iterate;

data.iterate(|inner| {
    // Iterative logic
    inner.map(|x| update(x))
})
```

## Testing Your Benchmarks

### Quick Test
```bash
# Run with small sample size for quick validation
cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name -- --sample-size 10
```

### Full Benchmark Run
```bash
# Run full benchmark with default parameters
cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name
```

### Baseline Comparison
```bash
# Save current results as baseline
cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name -- --save-baseline before

# Make changes...

# Compare against baseline
cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name -- --baseline before
```

### View Results
```bash
# HTML reports are generated at:
# target/criterion/<benchmark_name>/report/index.html
```

## Documentation

### Code Comments

Add clear comments to your benchmark:

```rust
/// Benchmark for testing XYZ operation.
/// 
/// This benchmark compares the performance of:
/// - Hydroflow: Using native operators
/// - Timely: Using standard dataflow operators
/// - Differential: Using collection-based operations
/// 
/// Dataset: N integers from 0 to N-1
/// Operation: Transform each element using function F
/// Measurement: Total time to process all elements
fn benchmark_xyz(c: &mut Criterion) {
    // Implementation...
}
```

### README Updates

Update relevant documentation:

1. `benches/README.md` - Add benchmark to the table
2. `README.md` - Update if adding new category
3. `CONTRIBUTING.md` - Update if introducing new patterns

## Code Style

### Rust Style

Follow Rust standard style:
```bash
cargo fmt -p hydro-timely-differential-benchmarks
cargo clippy -p hydro-timely-differential-benchmarks
```

### Naming Conventions

- **File names**: `lowercase_with_underscores.rs`
- **Function names**: `benchmark_framework_operation`
- **Constants**: `UPPER_CASE_WITH_UNDERSCORES`

Example:
```rust
const DATASET_SIZE: usize = 10_000;

fn benchmark_hydroflow_map(c: &mut Criterion) { ... }
fn benchmark_timely_map(c: &mut Criterion) { ... }
```

### Organization

Structure benchmarks consistently:
1. Imports
2. Constants
3. Helper functions
4. Benchmark functions (Hydroflow, Timely, Differential)
5. Criterion group registration

## Submitting Changes

### Before Submitting

1. **Test thoroughly**:
   ```bash
   cargo test -p hydro-timely-differential-benchmarks
   cargo bench -p hydro-timely-differential-benchmarks --bench your_benchmark_name -- --sample-size 10
   ```

2. **Format code**:
   ```bash
   cargo fmt -p hydro-timely-differential-benchmarks
   ```

3. **Check for issues**:
   ```bash
   cargo clippy -p hydro-timely-differential-benchmarks
   ```

4. **Update documentation**:
   - Add benchmark to README
   - Document any new patterns
   - Update CHANGELOG if applicable

### Commit Guidelines

Use clear, descriptive commit messages:

```
Add benchmark for symmetric hash join operation

- Implements Hydroflow version using join operator
- Implements Timely version using standard join
- Includes dataset of 10K entries
- Adds comparison of memory usage patterns
```

### Pull Request

1. Create a feature branch:
   ```bash
   git checkout -b add-benchmark-xyz
   ```

2. Make your changes and commit

3. Push to remote:
   ```bash
   git push origin add-benchmark-xyz
   ```

4. Create Pull Request with:
   - Clear title describing the change
   - Description of what benchmark tests
   - Results showing it works (sample benchmark output)
   - Any related issues

### PR Template

```markdown
## Description
Brief description of the benchmark being added

## Benchmark Category
- [ ] Basic Operations
- [ ] Control Flow
- [ ] Data Operations
- [ ] I/O Operations
- [ ] Complex Patterns

## Frameworks Compared
- [ ] Hydroflow
- [ ] Timely
- [ ] Differential

## Testing
- [ ] Benchmark compiles
- [ ] Benchmark runs successfully
- [ ] Results are reasonable
- [ ] Documentation updated

## Sample Results
```
benchmark_name/hydroflow   time: [XXX µs XXX µs XXX µs]
benchmark_name/timely      time: [XXX µs XXX µs XXX µs]
```
```

## Additional Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Hydroflow Documentation](https://hydro-project.github.io/hydro/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)

## Questions?

If you have questions about contributing:
1. Check existing benchmarks for examples
2. Review the README for usage patterns
3. Look at MIGRATION.md for historical context
4. Open an issue for discussion

## Thank You!

Your contributions help make Hydroflow better by providing valuable performance insights and comparisons. We appreciate your effort in maintaining high-quality benchmarks!
