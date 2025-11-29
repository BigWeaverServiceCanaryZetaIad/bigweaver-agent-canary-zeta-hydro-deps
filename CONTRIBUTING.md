# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmarks repository!

## Getting Started

### Prerequisites

1. **Rust Toolchain**: Version 1.91.1 (automatically managed via `rust-toolchain.toml`)
2. **Git**: For cloning and version control
3. **Access**: Ensure you have access to the main Hydro repository for dependencies

### Clone and Setup

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo check -p benches
```

## Repository Structure

```
.
├── benches/                      # Benchmark package
│   ├── benches/                  # Individual benchmark files
│   │   ├── *.rs                  # Benchmark implementations
│   │   └── *.txt                 # Data files for benchmarks
│   ├── Cargo.toml               # Benchmark dependencies
│   ├── build.rs                 # Build-time code generation
│   └── README.md                # Benchmark quick reference
├── BENCHMARKS.md                # Comprehensive benchmark documentation
├── Cargo.toml                   # Workspace configuration
├── README.md                    # Repository overview
└── CONTRIBUTING.md              # This file
```

## Development Workflow

### Making Changes

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**: Edit benchmark files or add new ones

3. **Test your changes**:
   ```bash
   # Check compilation
   cargo check -p benches
   
   # Run benchmarks
   cargo bench -p benches
   ```

4. **Format and lint**:
   ```bash
   cargo fmt
   cargo clippy -p benches -- -D warnings
   ```

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat(benches): add new benchmark for XYZ"
   ```

### Commit Message Format

Follow the Conventional Commits specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types**:
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `refactor`: Code refactoring
- `test`: Test-related changes
- `perf`: Performance improvements

**Examples**:
```
feat(benches): add streaming window benchmark
fix(reachability): correct edge count calculation
docs(README): update benchmark running instructions
chore(deps): update criterion to 0.5.1
```

## Adding New Benchmarks

### Step-by-Step Guide

1. **Create benchmark file**: `benches/benches/my_benchmark.rs`

2. **Implement benchmark** using this template:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
use timely::dataflow::operators::{ToStream, Map, Inspect};

const NUM_ITEMS: usize = 100_000;

fn benchmark_hydro(c: &mut Criterion) {
    c.bench_function("my_benchmark/hydro", |b| {
        b.iter(|| {
            let mut flow = dfir_syntax! {
                source_iter(0..NUM_ITEMS)
                    -> map(|x| x * 2)
                    -> for_each(|x| { black_box(x); });
            };
            flow.run_available();
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_benchmark/timely", |b| {
        b.iter(|| {
            timely::execute::example(|scope| {
                (0..NUM_ITEMS)
                    .to_stream(scope)
                    .map(|x| x * 2)
                    .inspect(|x| { black_box(*x); });
            });
        });
    });
}

criterion_group!(benches, benchmark_hydro, benchmark_timely);
criterion_main!(benches);
```

3. **Update `benches/Cargo.toml`**:

```toml
[[bench]]
name = "my_benchmark"
harness = false
```

4. **Add documentation**:
   - Update `benches/README.md` with benchmark description
   - Add detailed explanation in `BENCHMARKS.md`

5. **Test the benchmark**:

```bash
cargo bench -p benches --bench my_benchmark
```

6. **Review results**: Check `target/criterion/my_benchmark/report/index.html`

### Benchmark Best Practices

1. **Include multiple implementations**: Hydro, Timely, and optionally raw Rust
2. **Use consistent naming**: `<benchmark>/<framework>` pattern
3. **Black box results**: Use `black_box()` to prevent compiler optimizations
4. **Realistic data sizes**: Not too small (dominated by overhead) or too large (too slow)
5. **Document purpose**: Explain what is being measured and why
6. **Add data files**: If needed, place in `benches/benches/` directory

## Code Style

### Formatting

We use `rustfmt` with the configuration in `rustfmt.toml`:

```bash
cargo fmt --all
```

### Linting

We use `clippy` with the configuration in `clippy.toml`:

```bash
cargo clippy -p benches -- -D warnings
```

All warnings must be resolved before merging.

## Testing

### Running Benchmarks

```bash
# All benchmarks
cargo bench -p benches

# Specific benchmark
cargo bench -p benches --bench reachability

# Quick check (fewer samples)
cargo bench -p benches -- --sample-size 10

# Specific test pattern
cargo bench -p benches -- identity
```

### Verifying Results

1. Check that benchmarks complete without errors
2. Review generated reports in `target/criterion/`
3. Compare results to baseline if available
4. Look for unexpected performance characteristics

## Pull Request Process

1. **Create PR**: Push your branch and create a pull request

2. **PR Title Format**:
   ```
   [Type] Brief description (RequestId: XXX)
   ```

3. **PR Description** should include:
   - **Overview**: What changes were made
   - **Motivation**: Why these changes are needed
   - **Testing**: How you tested the changes
   - **Results**: Benchmark results if applicable
   - **Impact**: Any breaking changes or dependencies

4. **Review Process**:
   - Address reviewer feedback
   - Keep commits clean and logical
   - Ensure CI passes (when configured)

5. **Merging**:
   - PRs require approval before merging
   - Squash commits if requested
   - Delete branch after merge

## Dependency Updates

### Updating Main Repository Dependencies

When the main Hydro repository has updates:

1. Update git reference in `benches/Cargo.toml`:
   ```toml
   dfir_rs = { git = "https://github.com/...", rev = "abc123" }
   ```

2. Test all benchmarks:
   ```bash
   cargo update
   cargo bench -p benches
   ```

3. Document any API changes or breaking changes

### Updating Other Dependencies

1. Update version in `benches/Cargo.toml`
2. Run `cargo update -p <package>`
3. Test thoroughly
4. Document changes in commit message

## Reporting Issues

### Bug Reports

Include:
- Description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Rust version)
- Relevant benchmark results or logs

### Performance Issues

Include:
- Benchmark showing the issue
- Comparison to baseline or expected performance
- System specifications
- Criterion report output

### Feature Requests

Include:
- Description of the desired feature
- Use case and motivation
- Proposed implementation (if any)
- Example benchmark design

## Documentation

### Required Documentation

When adding benchmarks:
1. **Inline comments**: Explain non-obvious code
2. **benches/README.md**: Quick reference entry
3. **BENCHMARKS.md**: Detailed explanation
4. **Commit message**: Clear description of changes

### Documentation Style

- Use clear, concise language
- Include code examples where helpful
- Explain the "why" not just the "what"
- Keep README concise, use BENCHMARKS.md for details

## Questions and Support

For questions:
- Check existing documentation (README.md, BENCHMARKS.md)
- Review similar benchmarks for patterns
- Check the main Hydro repository for API documentation
- Open an issue for clarification

## Code of Conduct

Be respectful and professional in all interactions. We value:
- Constructive feedback
- Clear communication
- Collaborative problem-solving
- Inclusive language

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.
