# Contributing to Hydro Deps

Thank you for your interest in contributing to the Hydro dependencies repository! This repository contains benchmarks that compare dfir_rs/Hydro implementations against timely and differential-dataflow.

## Repository Purpose

This repository exists to:
- Isolate benchmarks that depend on timely and differential-dataflow
- Enable performance comparisons without burdening the main repository with heavy dependencies
- Provide a dedicated space for external dataflow system benchmarks

## When to Contribute Here

Contribute to this repository when you want to:
- ✅ Add benchmarks comparing dfir_rs to timely or differential-dataflow
- ✅ Update existing timely/differential comparison benchmarks
- ✅ Improve performance testing against external systems
- ✅ Add data files for benchmarks that use timely/differential

## When to Contribute to Main Repository

Contribute to `bigweaver-agent-canary-hydro-zeta` for:
- ❌ Benchmarks that don't use timely or differential-dataflow
- ❌ Core dfir_rs functionality
- ❌ Hydro language features
- ❌ Internal performance tests

## Getting Started

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository)
- Git
- Cargo
- Access to both repositories (main and deps)

### Setup

1. **Clone both repositories**:
   ```bash
   git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
   git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Build the deps repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo build
   ```

3. **Run tests**:
   ```bash
   cargo bench -p hydro-deps-benches
   ```

## Contribution Workflow

### 1. Before You Start

- Check existing issues for similar work
- Open an issue to discuss significant changes
- Review existing benchmarks for patterns

### 2. Making Changes

#### Adding a New Benchmark

1. **Create benchmark file**:
   ```bash
   touch benches/benches/my_new_benchmark.rs
   ```

2. **Implement benchmark** following the structure:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   
   fn benchmark_timely(c: &mut Criterion) {
       c.bench_function("my_benchmark/timely", |b| {
           b.iter(|| {
               // Implementation
           });
       });
   }
   
   fn benchmark_hydroflow(c: &mut Criterion) {
       c.bench_function("my_benchmark/dfir_rs", |b| {
           b.iter(|| {
               // Implementation
           });
       });
   }
   
   criterion_group!(my_benchmark, benchmark_timely, benchmark_hydroflow);
   criterion_main!(my_benchmark);
   ```

3. **Update `benches/Cargo.toml`**:
   ```toml
   [[bench]]
   name = "my_new_benchmark"
   harness = false
   ```

4. **Update `benches/README.md`** with benchmark description

5. **Update `BENCHMARK_DETAILS.md`** with detailed information

#### Modifying Existing Benchmarks

1. **Locate the benchmark**: `benches/benches/<name>.rs`
2. **Make your changes**
3. **Test thoroughly**: `cargo bench -p hydro-deps-benches --bench <name>`
4. **Update documentation** if behavior changes

### 3. Code Standards

#### Rust Style

- Follow Rust 2024 edition conventions
- Use `rustfmt` for formatting (inherited from main repo standards)
- Use `clippy` for linting (inherited from main repo standards)
- Write idiomatic Rust

#### Benchmark Standards

- **Use Criterion**: All benchmarks use the Criterion framework
- **Set `harness = false`**: Required for Criterion benchmarks
- **Name consistently**:
  - Files: `snake_case.rs`
  - Functions: `benchmark_<implementation>`
  - Groups: Descriptive names
- **Compare multiple implementations**: Include at least timely and dfir_rs
- **Verify correctness**: Assert that results match expected values
- **Use realistic data sizes**: Not too large (slow), not too small (noise)

#### Documentation Standards

- **In-code documentation**: Add comments explaining what's being tested
- **Function docs**: Document each benchmark function
- **README updates**: Keep `benches/README.md` current
- **BENCHMARK_DETAILS.md**: Add detailed analysis for new benchmarks

### 4. Testing

Before submitting:

```bash
# Build all
cargo build

# Run all benchmarks
cargo bench -p hydro-deps-benches

# Run specific benchmark
cargo bench -p hydro-deps-benches --bench your_benchmark

# Check formatting (if available)
cargo fmt -- --check

# Run clippy (if available)
cargo clippy -- -D warnings
```

### 5. Committing Changes

#### Commit Message Format

Follow the Conventional Commits specification:

```
<type>(<scope>): <description> [optional tag] (#PR-number)

[optional body]
```

**Types**:
- `feat`: New benchmark or feature
- `fix`: Bug fix in benchmark
- `docs`: Documentation updates
- `chore`: Maintenance tasks
- `test`: Test-related changes
- `refactor`: Code restructuring without behavior change

**Scopes**:
- `benches`: Benchmark changes
- `docs`: Documentation
- `deps`: Dependency updates
- `ci`: CI/CD changes

**Examples**:
```
feat(benches): add graph coloring benchmark (#123)
fix(benches): correct reachability verification logic (#124)
docs(benches): update BENCHMARK_DETAILS with new insights (#125)
chore(deps): update timely to 0.13.1 (#126)
```

### 6. Pull Requests

#### PR Title Format

Use the same conventional commit format:
```
feat(benches): Add comprehensive streaming join benchmark
```

#### PR Description Template

```markdown
## Overview
Brief description of what this PR does.

## Task Details
- ✅ Added new benchmark: `streaming_join.rs`
- ✅ Updated `benches/Cargo.toml`
- ✅ Updated `benches/README.md`
- ✅ Updated `BENCHMARK_DETAILS.md`

## Benefits
- 🎯 Enables comparison of join strategies
- 🎯 Provides baseline for join optimization work
- 🎯 Fills gap in dataflow pattern coverage

## Testing
- ✅ Benchmark compiles successfully
- ✅ Results are consistent across runs
- ✅ Verification assertions pass
- ✅ Performance is within expected range

## Impact Analysis

### Build Impact
- No impact on main repository
- Adds ~XXX ms to deps repository build time

### Runtime Impact
- Benchmark runs in ~XXX ms
- No impact on other benchmarks

### Breaking Changes
- None

## Related Changes
- Related to main repo PR: #XXX (if applicable)
- Companion PR in main repo: #XXX (if applicable)

## Affected Teams
- **Development Team**: Review benchmark implementation
- **Performance Testing Team**: Validate benchmark methodology
- **Documentation Team**: Review documentation updates

## Files Changed
- `benches/benches/streaming_join.rs` - New benchmark implementation
- `benches/Cargo.toml` - Added benchmark entry
- `benches/README.md` - Added benchmark description
- `BENCHMARK_DETAILS.md` - Added detailed analysis
```

### 7. Review Process

PRs will be reviewed for:
- ✅ Correctness of benchmark implementation
- ✅ Fair comparison between implementations
- ✅ Appropriate data sizes
- ✅ Code quality and style
- ✅ Documentation completeness
- ✅ Test coverage

### 8. Merging

- PRs require approval from maintainers
- All tests must pass
- Documentation must be complete
- Commit messages must follow conventions

## Coordinated Changes

### Changes Affecting Both Repositories

If your change affects both this repository and the main repository:

1. **Create PRs in both repositories**
2. **Link PRs in descriptions**:
   ```markdown
   ## Related Changes
   - Companion PR in main repo: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta#XXX
   ```
3. **Coordinate merging**: Ensure both are merged together
4. **Test both**: Verify changes work in both contexts

### Example Scenarios

- **New dfir_rs feature**: May require new benchmark here
- **Dependency updates**: May affect both repositories
- **API changes in main repo**: May break benchmarks here

## Best Practices

### Benchmark Design

- **Start simple**: Test one thing at a time
- **Build complexity gradually**: Add variants as needed
- **Verify correctness**: Always assert expected results
- **Use appropriate sizes**: Balance noise vs runtime
- **Minimize external factors**: Control what you're measuring

### Performance Considerations

- **Warm-up**: Criterion handles this, but be aware
- **Outliers**: Understand why they occur
- **System effects**: CPU scaling, background processes
- **Reproducibility**: Document system configuration if needed

### Documentation

- **Why over what**: Explain why benchmark exists
- **Expected results**: Document what good/bad looks like
- **Limitations**: Note any caveats or constraints
- **Interpretation**: Help others understand results

## Common Issues

### Benchmark Won't Compile

- ✅ Check dependencies in `benches/Cargo.toml`
- ✅ Verify `[[bench]]` entry exists
- ✅ Ensure imports are correct
- ✅ Check dfir_rs git reference is accessible

### Inconsistent Results

- ✅ Check for system interference
- ✅ Verify warm-up period is sufficient
- ✅ Look for non-deterministic operations
- ✅ Consider measurement noise for fast operations

### Tests Fail

- ✅ Verify expected results are correct
- ✅ Check data files are present
- ✅ Ensure algorithm correctness
- ✅ Review assertion logic

## Getting Help

- **Issues**: Open an issue with `question` label
- **Discussions**: Use GitHub discussions for general topics
- **Documentation**: Check `MIGRATION.md`, `BENCHMARK_DETAILS.md`
- **Examples**: Review existing benchmarks

## Code of Conduct

- Be respectful and professional
- Provide constructive feedback
- Help others learn
- Follow community guidelines

## Recognition

Contributors will be:
- Listed in commit history
- Acknowledged in release notes (for significant contributions)
- Appreciated by the team! 🎉

Thank you for contributing to Hydro! Your work helps us maintain high-quality performance comparisons and drive continuous improvement.
