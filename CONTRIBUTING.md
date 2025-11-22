# Contributing to Hydro Dependencies Benchmarks

Thank you for your interest in contributing! This document provides guidelines for contributing to the benchmark repository.

## Code of Conduct

Please be respectful and constructive in all interactions. We're here to improve performance benchmarking for the DFIR/Hydro project.

## How to Contribute

### Reporting Issues

Found a bug or have a suggestion? Please open an issue with:

1. **Clear title**: Summarize the issue
2. **Description**: Detailed explanation
3. **Steps to reproduce**: For bugs
4. **Expected vs actual behavior**: What should happen vs. what does happen
5. **Environment**: OS, Rust version, etc.

### Adding New Benchmarks

New benchmarks are welcome! Follow these steps:

#### 1. Plan Your Benchmark

Before coding, consider:
- **What are you measuring?** (specific performance characteristic)
- **Why is it important?** (real-world relevance)
- **What frameworks to compare?** (Timely, Differential, DFIR/Hydro)
- **What baselines to include?** (raw Rust, iterators, etc.)

#### 2. Implement the Benchmark

Create `benches/your_benchmark.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

// Baseline: raw Rust implementation
fn benchmark_baseline(c: &mut Criterion) {
    c.bench_function("your_benchmark/baseline", |b| {
        b.iter(|| {
            // Your baseline implementation
            let result = do_work();
            black_box(result);  // Prevent optimization
        });
    });
}

// Timely implementation
fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Inspect};
    
    c.bench_function("your_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute_directly(|worker| {
                // Your timely implementation
            });
        });
    });
}

// DFIR implementation
fn benchmark_dfir(c: &mut Criterion) {
    use dfir_rs::dfir_syntax;
    
    c.bench_function("your_benchmark/dfir", |b| {
        b.iter(|| {
            let mut df = dfir_syntax! {
                // Your DFIR implementation
            };
            df.run_available_sync();
        });
    });
}

criterion_group!(
    your_benchmark_group,
    benchmark_baseline,
    benchmark_timely,
    benchmark_dfir,
);
criterion_main!(your_benchmark_group);
```

#### 3. Register the Benchmark

Add to `Cargo.toml`:

```toml
[[bench]]
name = "your_benchmark"
harness = false
```

#### 4. Test Your Benchmark

```bash
# Verify it compiles
cargo build --bench your_benchmark --release

# Run it
cargo bench --bench your_benchmark -- --quick

# Check full run
cargo bench --bench your_benchmark
```

#### 5. Document Your Benchmark

Add to README.md under the appropriate section:

```markdown
#### Your Benchmark (`your_benchmark.rs`)
**What it tests**: Brief description
**Frameworks compared**: List frameworks
**Key metric**: What to measure
**Purpose**: Why this benchmark matters

\`\`\`bash
cargo bench --bench your_benchmark
\`\`\`

**Interpreting results**:
- Key insight 1
- Key insight 2
```

### Improving Existing Benchmarks

To improve an existing benchmark:

1. **Understand current implementation**: Read the code and documentation
2. **Identify the improvement**: What are you fixing/enhancing?
3. **Maintain compatibility**: Don't break historical comparisons without good reason
4. **Document changes**: Explain why the change improves things

### Updating Dependencies

When updating framework dependencies:

```bash
# Update Cargo.lock
cargo update

# Test all benchmarks
cargo bench --benches -- --quick

# Verify no regressions
cargo bench
```

**Important**: Major version updates may invalidate historical comparisons. Document this clearly.

## Code Style

### Rust Style

- Follow standard Rust conventions
- Use `rustfmt`: `cargo fmt`
- Use `clippy`: `cargo clippy --benches`
- Keep code readable over clever

### Benchmark Structure

```rust
// 1. Imports at top
use criterion::{...};

// 2. Constants (if needed)
const DATA_SIZE: usize = 1_000_000;

// 3. Helper functions
fn generate_test_data() -> Vec<i32> { ... }

// 4. Benchmark functions (grouped by framework)
fn benchmark_baseline(c: &mut Criterion) { ... }
fn benchmark_timely(c: &mut Criterion) { ... }
fn benchmark_dfir(c: &mut Criterion) { ... }

// 5. Criterion group and main
criterion_group!(...);
criterion_main!(...);
```

### Documentation

- **Code comments**: Explain non-obvious logic
- **Function docs**: Use `///` doc comments for public helpers
- **README updates**: Keep documentation in sync with code
- **Inline notes**: Mark temporary workarounds with `// TODO:` or `// NOTE:`

## Testing

### Before Submitting

Run this checklist:

```bash
# Format code
cargo fmt --all

# Check for issues
cargo clippy --benches -- -D warnings

# Build all benchmarks
cargo build --benches --release

# Quick test all benchmarks
cargo bench --benches -- --quick

# Run full benchmarks (optional, takes time)
cargo bench
```

### Validation

Ensure your benchmark:
- [ ] Compiles without warnings
- [ ] Produces consistent results across runs
- [ ] Includes `black_box()` for outputs
- [ ] Documents what it measures
- [ ] Compares fairly across frameworks

## Pull Request Process

### 1. Fork and Branch

```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/YOUR_USERNAME/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Create a feature branch
git checkout -b add-your-benchmark-name
```

### 2. Make Changes

- Follow the guidelines above
- Commit logically (one feature/fix per commit)
- Write clear commit messages

### 3. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(benches): add graph coloring benchmark

Implements graph coloring benchmark comparing Differential Dataflow
incremental approach with DFIR batch processing.

- Adds benchmark for 3-coloring problem
- Includes test graphs of various sizes  
- Documents performance characteristics
```

Format: `type(scope): description`

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code restructuring
- `perf`: Performance improvement
- `test`: Adding or fixing tests
- `chore`: Maintenance tasks

### 4. Push and Create PR

```bash
git push origin add-your-benchmark-name
```

Then create a Pull Request on GitHub with:

**Title**: Brief description of changes
```
feat(benches): add graph coloring benchmark
```

**Description**:
```markdown
## Overview
Brief summary of what this PR does.

## Task Details
- Adds graph coloring benchmark
- Compares Differential vs DFIR
- Includes documentation in README

## Changes Made
### Benchmark Files Added
- `benches/graph_coloring.rs`: Main benchmark implementation

### Documentation Added
- Updated README.md with benchmark description
- Added usage examples

## Benefits
- **Performance insight**: Measures incremental graph algorithms
- **Real-world relevance**: Graph coloring is common in scheduling
- **Framework comparison**: Shows strengths of each approach

## Testing
- [x] Compiles without warnings
- [x] Runs successfully with `--quick`
- [x] Produces consistent results
- [x] Documentation is clear
```

### 5. Review Process

Your PR will be reviewed for:
- **Correctness**: Does it work?
- **Performance**: Is it a fair comparison?
- **Documentation**: Is it well-documented?
- **Code quality**: Follows style guidelines?
- **Relevance**: Is it useful?

Address review feedback promptly and clearly.

## Best Practices

### DO ✅

- **Use `black_box()`**: Prevent compiler from optimizing away work
- **Document assumptions**: Explain why you implemented something a certain way
- **Include baselines**: Raw Rust for context
- **Test on multiple machines**: Performance varies
- **Version control data**: Include test data or document where to get it

### DON'T ❌

- **Cherry-pick results**: Report all outcomes, not just favorable ones
- **Optimize unfairly**: Don't over-optimize one framework
- **Ignore statistical significance**: Use Criterion's analysis
- **Break compatibility**: Preserve ability to compare with historical data
- **Copy-paste without understanding**: Understand the code you're adding

## Communication

### Questions?

- **Implementation questions**: Comment on the relevant PR/issue
- **Design discussions**: Open an issue first before implementing large features
- **Performance questions**: Reference [PERFORMANCE_COMPARISON.md](./PERFORMANCE_COMPARISON.md)

### Be Patient

Reviews may take time. This is a volunteer effort. Follow up politely if needed.

## Recognition

Contributors will be recognized in:
- Git history (your commits)
- Release notes (for significant contributions)
- README.md (for major features)

Thank you for contributing to better performance understanding of DFIR/Hydro!

## Additional Resources

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
