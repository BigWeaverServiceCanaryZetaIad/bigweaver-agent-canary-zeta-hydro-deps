# Contributing to Hydro Benchmarks

Thank you for your interest in contributing to the Hydro benchmark repository! This guide will help you contribute effectively.

## Table of Contents

- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Development Setup](#development-setup)
- [Adding Benchmarks](#adding-benchmarks)
- [Code Standards](#code-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Review Process](#review-process)

## Getting Started

### Prerequisites

- Rust toolchain (1.70 or later)
- Git
- Familiarity with Criterion benchmarking framework
- Understanding of Hydro (dfir_rs) or willingness to learn

### Initial Setup

1. **Fork the repository** on GitHub

2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

4. **Verify setup**:
   ```bash
   cargo bench -p hydro-benchmarks --bench arithmetic
   ```

## Types of Contributions

### 1. New Benchmarks

Add benchmarks for:
- New dataflow patterns
- Different workload sizes
- Alternative implementations
- Real-world use cases

### 2. Improvements

Improve existing benchmarks:
- Better measurement methodology
- More realistic data
- Additional variants
- Performance optimizations

### 3. Documentation

Enhance documentation:
- Clarify benchmark descriptions
- Add usage examples
- Improve troubleshooting guides
- Fix typos and errors

### 4. Tools and Scripts

Improve tooling:
- Better comparison scripts
- Analysis tools
- CI/CD integration
- Visualization improvements

### 5. Bug Fixes

Fix issues:
- Benchmark measurement errors
- Build problems
- Documentation errors
- Script bugs

## Development Setup

### Local Development with Main Repository

For testing changes to dfir_rs:

1. **Clone main repository**:
   ```bash
   cd ..
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   ```

2. **Update benches/Cargo.toml**:
   ```toml
   dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
   sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. **Test changes**:
   ```bash
   cargo bench -p hydro-benchmarks
   ```

4. **Revert before committing**:
   ```toml
   dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = ["debugging"] }
   sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
   ```

### Branch Strategy

- **main**: Stable, production-ready code
- **feature branches**: `feature/benchmark-name` or `feature/description`
- **fix branches**: `fix/issue-description`

Create feature branch:
```bash
git checkout -b feature/my-new-benchmark
```

## Adding Benchmarks

### Step-by-Step Guide

#### 1. Create Benchmark File

Create `benches/benches/my_benchmark.rs`:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;

// Constants for benchmark configuration
const DATA_SIZE: usize = 1_000_000;

fn benchmark_dfir_rs_compiled(c: &mut Criterion) {
    use dfir_rs::sinktools::{SinkBuild, SinkBuilder, ToSinkBuild};
    
    c.bench_function("my_benchmark/dfir_rs/compiled", |b| {
        b.to_async(tokio::runtime::Runtime::new().unwrap())
            .iter(|| async {
                // Your dfir_rs implementation
                let mut builder = SinkBuilder::new();
                
                let input = builder.source_interval(tokio::time::Duration::from_secs(1));
                let output = input.map(|x| x * 2);
                
                builder.add_sink(output);
                
                let mut sink_state = builder.build_for_run();
                sink_state.run().await;
                
                black_box(());
            });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    use timely::dataflow::operators::{ToStream, Map, Inspect};
    
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute_directly(move |worker| {
                worker.dataflow::<(), _, _>(|scope| {
                    (0..DATA_SIZE)
                        .to_stream(scope)
                        .map(|x| x * 2)
                        .inspect(|x| { black_box(x); });
                });
            });
        });
    });
}

criterion_group!(benches, benchmark_dfir_rs_compiled, benchmark_timely);
criterion_main!(benches);
```

#### 2. Register Benchmark

Add to `benches/Cargo.toml`:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

#### 3. Test Locally

```bash
cargo bench -p hydro-benchmarks --bench my_benchmark
```

#### 4. Document Benchmark

Add to `benches/README.md`:

```markdown
### 9. My Benchmark (`my_benchmark.rs`)
**Purpose**: Description of what this benchmark tests  
**Operations**: Specific operations being measured  
**Variants**:
- `my_benchmark/dfir_rs/compiled`: Compiled dfir_rs implementation
- `my_benchmark/timely`: Timely dataflow implementation

**Lines of Code**: ~XXX
```

#### 5. Update MANIFEST.md

Add entry to file listing.

### Benchmark Guidelines

#### Naming Conventions

- **File name**: lowercase with underscores (e.g., `graph_processing.rs`)
- **Function names**: `benchmark_<implementation>_<variant>`
- **Benchmark IDs**: `category/implementation/variant`

Examples:
- `graph_processing/dfir_rs/compiled`
- `string_ops/timely/multithreaded`

#### Data Sizes

Choose data sizes that:
- Complete in reasonable time (< 10 seconds per iteration)
- Exercise realistic workloads
- Minimize measurement noise
- Are consistent across variants

#### Variants to Include

For comprehensive comparison, include:
1. **dfir_rs/compiled**: Compiled Hydro implementation
2. **dfir_rs/scheduled**: Scheduled Hydro implementation (if applicable)
3. **timely**: Timely dataflow implementation (if applicable)
4. **differential**: Differential dataflow (for incremental computation)
5. **raw**: Raw Rust baseline (for reference)

#### What to Measure

Focus on:
- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Scalability**: Performance with varying data sizes
- **Consistency**: Variance in measurements

Avoid measuring:
- One-time setup costs (unless specifically testing initialization)
- I/O operations (unless that's the focus)
- Random external factors

## Code Standards

### Rust Style

Follow standard Rust conventions:
- Use `rustfmt` for formatting
- Use `clippy` for linting
- Write idiomatic Rust code

```bash
# Format code
cargo fmt

# Run linter
cargo clippy -p hydro-benchmarks
```

### Code Quality

- **Clear variable names**: Descriptive, not abbreviated
- **Comments**: Explain non-obvious logic
- **Error handling**: Proper error handling even in benchmarks
- **No warnings**: Code should compile without warnings

### Performance Considerations

- Use `black_box()` to prevent compiler optimizations from skewing results
- Avoid allocations in hot paths unless testing allocation performance
- Be consistent across variants for fair comparison

## Testing

### Before Submitting

Run these checks:

```bash
# 1. Format code
cargo fmt

# 2. Run clippy
cargo clippy -p hydro-benchmarks

# 3. Build benchmarks
cargo build -p hydro-benchmarks

# 4. Test your benchmark
cargo bench -p hydro-benchmarks --bench your_benchmark

# 5. Run all benchmarks to ensure nothing broke
cargo bench -p hydro-benchmarks
```

### Verification Checklist

- [ ] Benchmark compiles without errors
- [ ] Benchmark runs to completion
- [ ] Results are consistent across runs
- [ ] Documentation is complete
- [ ] MANIFEST.md is updated
- [ ] Code is formatted (cargo fmt)
- [ ] No clippy warnings
- [ ] Local paths reverted to git dependencies

## Documentation

### Documentation Requirements

Every contribution should include:

1. **Code comments**: Explain complex logic
2. **README updates**: Document new benchmarks
3. **MANIFEST updates**: List new files
4. **Inline documentation**: Use doc comments for public items

### Documentation Style

- **Clear and concise**: Get to the point
- **Examples**: Provide usage examples
- **Context**: Explain why, not just what
- **Audience awareness**: Write for your audience level

### Required Documentation

For new benchmarks:
- Purpose and goals
- Benchmark variants
- Data sizes and configuration
- Expected results
- Interpretation guidance

## Pull Request Process

### 1. Prepare Your Changes

```bash
# Ensure you're on latest main
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/my-changes

# Make changes...

# Stage and commit
git add .
git commit -m "feat(benches): add graph processing benchmark"
```

### 2. Commit Message Format

Follow conventional commits:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types**:
- `feat`: New feature (benchmark, script)
- `fix`: Bug fix
- `docs`: Documentation only
- `chore`: Maintenance tasks
- `refactor`: Code refactoring
- `perf`: Performance improvements

**Examples**:
```
feat(benches): add graph processing benchmark

Adds comprehensive graph processing benchmarks comparing dfir_rs, timely,
and differential implementations.

feat(scripts): add performance regression detection script

docs(readme): clarify local development setup

fix(benches): correct reachability data file path
```

### 3. Push and Create PR

```bash
# Push to your fork
git push origin feature/my-changes
```

Create PR on GitHub with:
- **Clear title**: Following commit message format
- **Description**: What, why, how
- **Testing**: How you tested the changes
- **Screenshots**: If relevant (benchmark results, graphs)

### 4. PR Template

```markdown
## Overview
Brief description of changes

## Motivation
Why these changes are needed

## Changes Made
- List of specific changes
- What was added/modified/removed

## Testing
- [ ] Benchmarks compile
- [ ] Benchmarks run successfully
- [ ] Results are consistent
- [ ] Documentation updated
- [ ] All checks pass

## Benchmark Results
```
(paste relevant benchmark results)
```

## Related Issues
Closes #XXX
```

## Review Process

### What Reviewers Look For

1. **Correctness**: Benchmark measures what it claims
2. **Performance**: Reasonable execution time
3. **Consistency**: Results are reproducible
4. **Documentation**: Clear and complete
5. **Code quality**: Clean, idiomatic Rust
6. **No regressions**: Doesn't break existing benchmarks

### Responding to Feedback

- **Be responsive**: Reply to comments promptly
- **Be open**: Consider suggestions objectively
- **Ask questions**: If feedback is unclear
- **Make changes**: Update PR based on feedback
- **Re-request review**: After addressing comments

### Approval Process

- PRs require approval from at least one maintainer
- All CI checks must pass
- No unresolved comments
- Documentation must be complete

## Best Practices

### Do's

✅ Test thoroughly before submitting  
✅ Write clear commit messages  
✅ Update documentation  
✅ Follow code standards  
✅ Keep PRs focused and manageable  
✅ Respond to review feedback  
✅ Ask questions when unclear  

### Don'ts

❌ Submit untested code  
❌ Make unrelated changes in same PR  
❌ Ignore CI failures  
❌ Leave local development paths in commits  
❌ Skip documentation updates  
❌ Argue with reviewers defensively  
❌ Make changes after approval without notification  

## Getting Help

### Resources

- **[README.md](README.md)**: Repository overview
- **[QUICKSTART.md](QUICKSTART.md)**: Getting started guide
- **[benches/README.md](benches/README.md)**: Benchmark documentation
- **Main repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

### Asking Questions

- **GitHub Issues**: For bugs or feature requests
- **Pull Requests**: For code-specific questions
- **Team channels**: For general questions

### Common Issues

See [QUICKSTART.md](QUICKSTART.md) troubleshooting section.

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 license.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn and grow

## Thank You!

Your contributions make this project better for everyone. We appreciate your time and effort!

---

**Questions?** Open an issue or reach out to the team. We're here to help!
