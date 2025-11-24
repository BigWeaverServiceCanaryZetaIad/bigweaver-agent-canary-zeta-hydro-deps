# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmarking repository!

## Overview

This repository contains performance benchmarks comparing Hydro's dataflow implementation with timely-dataflow and differential-dataflow. Contributions that improve benchmark coverage, accuracy, or add new performance comparisons are welcome.

## Getting Started

### Prerequisites

- Rust 1.75 or later
- Git
- Familiarity with dataflow programming concepts

### Setting Up Development Environment

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the project:
   ```bash
   cargo build
   ```

3. Run existing benchmarks:
   ```bash
   cargo bench
   ```

## Development Workflow

### 1. Creating a New Benchmark

When adding a new benchmark:

1. **Create the benchmark file** in `benches/benches/`:
   ```bash
   touch benches/benches/my_benchmark.rs
   ```

2. **Add benchmark entry** to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. **Structure your benchmark** following this pattern:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn benchmark_timely(c: &mut Criterion) {
       c.bench_function("timely_implementation", |b| {
           b.iter(|| {
               // Timely implementation
           });
       });
   }
   
   fn benchmark_hydroflow(c: &mut Criterion) {
       c.bench_function("hydroflow_implementation", |b| {
           b.iter(|| {
               // Hydroflow implementation
           });
       });
   }
   
   criterion_group!(benches, benchmark_timely, benchmark_hydroflow);
   criterion_main!(benches);
   ```

4. **Include multiple implementations** for comparison:
   - Timely-dataflow
   - Differential-dataflow (if applicable)
   - Hydroflow (dfir_rs)
   - Raw Rust baseline (if applicable)

### 2. Adding Data Files

If your benchmark requires data files:

1. Place data files in `benches/benches/`
2. Keep files reasonably sized (< 10MB if possible)
3. Document the data source and format
4. Add `.gitignore` entries if files are generated

### 3. Code Style

This repository follows standard Rust formatting:

- Use `rustfmt` for formatting:
  ```bash
  cargo fmt
  ```

- Use `clippy` for linting:
  ```bash
  cargo clippy
  ```

- Follow the workspace lint configuration defined in `Cargo.toml`

### 4. Testing Your Changes

Before submitting:

1. **Run all benchmarks**:
   ```bash
   cargo bench
   ```

2. **Check for compilation errors**:
   ```bash
   cargo check
   ```

3. **Run linting**:
   ```bash
   cargo clippy -- -D warnings
   ```

4. **Format code**:
   ```bash
   cargo fmt
   ```

## Benchmark Guidelines

### Performance Considerations

- Ensure benchmarks are deterministic
- Use appropriate iteration counts for accurate measurements
- Avoid external I/O in hot paths
- Consider using black_box to prevent compiler optimizations
- Warm up code paths before measurement

### Documentation

Each benchmark should include:

- **Purpose**: What aspect of performance is being measured
- **Implementations**: Which variants are being compared
- **Expected behavior**: What results are considered normal
- **Data requirements**: Any external data files needed

Example benchmark header:
```rust
//! # Join Operations Benchmark
//!
//! Compares join operation performance across:
//! - Timely-dataflow
//! - Differential-dataflow
//! - Hydroflow (dfir_rs)
//!
//! Tests both small (< 1000 elements) and large (> 100k elements) datasets.
```

## Pull Request Process

### 1. Branch Naming

Use descriptive branch names with type prefix:
- `feat/add-aggregation-benchmark`
- `fix/reachability-data-loading`
- `docs/update-benchmark-guide`
- `perf/optimize-join-benchmark`

### 2. Commit Messages

Follow conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Examples:
- `feat(benches): add aggregation operations benchmark`
- `fix(reachability): correct edge data file loading`
- `docs(readme): update benchmark running instructions`
- `perf(join): optimize baseline implementation`

### 3. Pull Request Description

Use the team's structured PR format:

```markdown
## Overview

Brief description of the changes and motivation.

## Task Details

- [ ] Task item 1
- [ ] Task item 2
- [ ] Task item 3

## Changes Made

✅ Change 1
✅ Change 2
✅ Change 3

## Benchmark Results

Include relevant benchmark results showing:
- Performance comparisons
- Any significant changes in metrics
- Regression test results

## Testing

- [ ] All benchmarks run successfully
- [ ] Code passes clippy checks
- [ ] Code is formatted with rustfmt
- [ ] Documentation is updated

## Related Changes

- Related PR #XXX
- Issue #XXX
```

### 4. Review Process

- PRs require review before merging
- Address all review comments
- Ensure CI passes (when available)
- Keep PRs focused and atomic

## Benchmark Best Practices

### 1. Fair Comparisons

- Use equivalent algorithms across implementations
- Ensure same data structures where possible
- Account for setup costs appropriately
- Compare apples to apples

### 2. Statistical Rigor

- Use criterion's statistical analysis
- Run sufficient iterations for confidence
- Report confidence intervals
- Note any outliers or anomalies

### 3. Reproducibility

- Document system requirements
- Note any environmental dependencies
- Provide clear setup instructions
- Include sample data or generators

### 4. Maintenance

- Update benchmarks as implementations evolve
- Keep dependencies current
- Archive deprecated benchmarks with documentation
- Track performance trends over time

## Adding Dependencies

When adding new dependencies:

1. Add to `benches/Cargo.toml`
2. Use specific version constraints
3. Document why the dependency is needed
4. Consider impact on build time

## Documentation

Keep documentation current:

- Update README.md for new benchmarks
- Update this CONTRIBUTING.md for process changes
- Document benchmark methodology
- Explain performance expectations

## Issue Reporting

When reporting issues:

### Bug Reports

Include:
- Benchmark name
- Expected behavior
- Actual behavior
- Steps to reproduce
- System information (OS, Rust version)
- Benchmark output/logs

### Feature Requests

Include:
- Description of proposed benchmark
- Rationale for addition
- Expected implementations to compare
- Any special requirements

### Performance Issues

Include:
- Benchmark exhibiting issue
- Performance metrics
- Comparison with expected performance
- System information
- Profiling data (if available)

## Code Review Guidelines

When reviewing PRs:

- Check for correct benchmark methodology
- Verify statistical validity
- Ensure fair comparisons
- Review documentation completeness
- Test benchmark execution
- Verify reproducibility

## Communication

- Keep discussions focused and professional
- Ask clarifying questions
- Provide constructive feedback
- Reference specific lines or files
- Use benchmark data to support arguments

## Questions?

If you have questions:

1. Check existing documentation
2. Review closed issues and PRs
3. Contact the team
4. Refer to main hydro repository documentation

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

---

Thank you for contributing to Hydro benchmarking! Your efforts help us maintain and improve the framework's performance.
