# Contributing to Timely-Differential Benchmarks

Thank you for your interest in contributing to the Hydroflow benchmark suite!

## Getting Started

### Prerequisites

- Rust toolchain (latest stable or as specified in the main Hydro repository)
- Git
- Basic understanding of dataflow programming concepts

### Repository Setup

```bash
# Clone the repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the project
cargo build

# Run tests (benchmarks)
cargo bench --no-run
```

## Development Workflow

### Using Local Hydro Repository

For development, you'll likely want to use a local copy of the main Hydro repository:

1. Clone both repositories side by side:
```bash
/projects/
  ├── bigweaver-agent-canary-hydro-zeta/
  └── bigweaver-agent-canary-zeta-hydro-deps/
```

2. Update `Cargo.toml` to use local paths:
```toml
[dev-dependencies]
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

3. Remember to revert these changes before committing!

## Adding New Benchmarks

### Benchmark Structure

Each benchmark file should follow this structure:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use dfir_rs::dfir_syntax;
// Other imports...

// Define benchmark functions
fn benchmark_raw(c: &mut Criterion) {
    c.bench_function("category/raw", |b| {
        b.iter(|| {
            // Raw Rust implementation
        });
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("category/dfir_rs", |b| {
        b.iter(|| {
            // Hydroflow implementation
        });
    });
}

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("category/timely", |b| {
        b.iter(|| {
            // Timely implementation
        });
    });
}

fn benchmark_differential(c: &mut Criterion) {
    c.bench_function("category/differential", |b| {
        b.iter(|| {
            // Differential-dataflow implementation
        });
    });
}

criterion_group!(
    benches,
    benchmark_raw,
    benchmark_hydroflow,
    benchmark_timely,
    benchmark_differential
);
criterion_main!(benches);
```

### Steps to Add a New Benchmark

1. **Create the benchmark file** in `benches/<benchmark_name>.rs`

2. **Implement multiple versions** for comparison:
   - Raw Rust baseline
   - Hydroflow/DFIR implementation
   - Timely implementation (if applicable)
   - Differential-dataflow implementation (if applicable)

3. **Register the benchmark** in `Cargo.toml`:
```toml
[[bench]]
name = "benchmark_name"
harness = false
```

4. **Test the benchmark**:
```bash
cargo bench --bench benchmark_name -- --quick
```

5. **Update documentation**:
   - Add benchmark description to `README.md`
   - Document any data files or special requirements
   - Update this `CONTRIBUTING.md` if needed

### Benchmark Best Practices

- **Use `black_box`**: Prevent compiler optimizations from eliminating code
- **Consistent data sizes**: Use similar data volumes across implementations
- **Meaningful metrics**: Measure what matters (throughput, latency, memory)
- **Clear naming**: Use descriptive function and group names
- **Documentation**: Add comments explaining benchmark purpose and expected results
- **Data files**: Place in `benches/` directory and document source/format

## Code Style

### Rust Formatting

```bash
# Format code (if rustfmt.toml exists in main repo, follow those rules)
cargo fmt

# Check formatting
cargo fmt -- --check
```

### Linting

```bash
# Run clippy
cargo clippy --all-targets

# Fix clippy warnings
cargo clippy --all-targets --fix
```

## Testing

While this is a benchmark repository, you should verify:

1. **Benchmarks compile**: `cargo bench --no-run`
2. **Benchmarks run**: `cargo bench --bench <name> -- --quick`
3. **Results are reasonable**: Check that performance numbers make sense
4. **No panics or errors**: Ensure benchmarks complete successfully

## Commit Messages

Follow the Conventional Commits specification:

```
type(scope): description

[optional body]

[optional footer]
```

### Types
- `feat`: New benchmark or feature
- `fix`: Bug fix in existing benchmark
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `refactor`: Code refactoring without behavior change
- `perf`: Performance improvements

### Examples

```
feat(benchmarks): add new graph algorithm benchmark

Add benchmark comparing BFS implementations across frameworks.

Closes #123
```

```
fix(reachability): correct edge loading in benchmark

The benchmark was loading edges incorrectly, causing invalid results.
```

```
docs(readme): update benchmark descriptions

Add more detailed explanations of what each benchmark measures.
```

## Pull Request Process

1. **Create a feature branch**:
```bash
git checkout -b feat/add-new-benchmark-YYYYMMDD-HHMMSS
```

2. **Make your changes** following the guidelines above

3. **Test thoroughly**:
```bash
cargo bench --no-run
cargo bench --bench your_benchmark -- --quick
```

4. **Commit your changes** with conventional commit messages

5. **Push to remote**:
```bash
git push origin feat/add-new-benchmark-YYYYMMDD-HHMMSS
```

6. **Create a pull request** with:
   - Clear title and description
   - Overview of changes
   - Benchmark results (if applicable)
   - Any breaking changes or dependencies
   - Testing performed

### PR Template

```markdown
## Overview
Brief description of the changes

## Task Details
- [ ] Task 1
- [ ] Task 2

## Changes Made
- Detailed list of changes

## Benchmark Results
(If applicable) Include sample benchmark output

## Testing
- [ ] Benchmarks compile
- [ ] Benchmarks run successfully
- [ ] Results are reasonable
- [ ] Documentation updated

## Related Changes
Link to related PRs or issues
```

## Performance Guidelines

### Benchmark Duration

- Quick benchmarks: Complete in < 10 seconds
- Full benchmarks: Complete in < 5 minutes
- Use appropriate sample sizes to balance accuracy and speed

### Memory Usage

- Be mindful of memory consumption
- Document memory-intensive benchmarks
- Consider providing smaller test data sets

### Reproducibility

- Use fixed random seeds when applicable
- Document environment dependencies
- Avoid timing-sensitive operations

## Documentation

### Code Comments

- Explain non-obvious implementation details
- Document parameter choices
- Reference papers or algorithms when applicable

### README Updates

When adding benchmarks, update `README.md`:
- Add to the "Available Benchmarks" list
- Describe what the benchmark measures
- Note any special requirements or data files

## Questions and Support

- Check existing benchmarks for examples
- Refer to the main Hydro repository documentation
- Review Criterion.rs documentation for benchmark harness details

## License

All contributions will be licensed under Apache-2.0, consistent with the main Hydro project.
