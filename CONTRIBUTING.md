# Contributing to Hydro-Deps Benchmarks

Thank you for your interest in contributing to the Hydroflow performance benchmark suite! This guide will help you understand how to contribute effectively.

## Repository Purpose

This repository maintains performance comparison benchmarks between Hydroflow and external dataflow frameworks (Timely Dataflow and Differential Dataflow). It exists separately from the main Hydroflow repository to:

- Avoid external framework dependencies in the core project
- Enable independent benchmark execution
- Facilitate performance regression testing
- Support framework comparison studies

## Getting Started

### Prerequisites

- Rust 1.70 or later
- Git
- Basic understanding of dataflow programming
- Familiarity with the Criterion benchmarking framework

### Setting Up

1. Clone the repository:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

2. Run existing benchmarks to verify setup:
```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
```

3. Explore the codebase:
```bash
# Review existing benchmarks
ls benches/benches/
# Read documentation
cat benches/README.md
```

## Types of Contributions

### 1. Adding New Benchmarks

New benchmarks should:
- Test a specific dataflow pattern or operation
- Include implementations for multiple frameworks (Timely, Differential, Hydroflow)
- Use realistic data sizes and operations
- Follow existing code structure

**Steps:**

1. Create a new file in `benches/benches/`:
```rust
// benches/benches/my_pattern.rs
use criterion::{Criterion, black_box, criterion_group, criterion_main};
use timely::dataflow::operators::{ToStream, Inspect};
use dfir_rs::dfir_syntax;

const DATA_SIZE: usize = 100_000;

fn benchmark_timely(c: &mut Criterion) {
    c.bench_function("my_pattern/timely", |b| {
        b.iter(|| {
            timely::example(|scope| {
                (0..DATA_SIZE)
                    .to_stream(scope)
                    .inspect(|x| { black_box(x); });
            });
        })
    });
}

fn benchmark_hydroflow(c: &mut Criterion) {
    c.bench_function("my_pattern/dfir_rs", |b| {
        b.iter_batched(
            || {
                dfir_syntax! {
                    source_iter(0..DATA_SIZE)
                        -> for_each(|x| { black_box(x); });
                }
            },
            |mut df| {
                df.run_available_sync();
            },
            criterion::BatchSize::SmallInput,
        )
    });
}

criterion_group!(benches, benchmark_timely, benchmark_hydroflow);
criterion_main!(benches);
```

2. Add benchmark entry to `benches/Cargo.toml`:
```toml
[[bench]]
name = "my_pattern"
harness = false
```

3. Document the benchmark in `benches/README.md`

4. Test the benchmark:
```bash
cargo bench --bench my_pattern
```

### 2. Improving Existing Benchmarks

When modifying benchmarks:
- Maintain compatibility with existing tests
- Document changes in commit messages
- Verify performance doesn't regress unexpectedly
- Update documentation to reflect changes

**Steps:**

1. Make changes to the benchmark file
2. Run the benchmark to verify:
```bash
cargo bench --bench <benchmark-name>
```
3. Compare results with previous runs
4. Update documentation if needed

### 3. Documentation Improvements

Documentation contributions are highly valued:
- Clarify benchmark purpose and usage
- Add examples and use cases
- Improve setup instructions
- Document troubleshooting steps

### 4. Bug Fixes

When fixing bugs:
- Describe the problem clearly
- Explain the solution
- Add tests if applicable
- Verify the fix doesn't break other benchmarks

## Code Style and Standards

### Rust Formatting

Follow standard Rust formatting:
```bash
# Format code before committing
cargo fmt --all

# Check for common issues
cargo clippy --all-targets
```

### Benchmark Structure

Follow this structure for consistency:

```rust
use criterion::{Criterion, black_box, criterion_group, criterion_main};

// Constants at the top
const DATA_SIZE: usize = 100_000;
const NUM_OPS: usize = 20;

// Benchmark functions
fn benchmark_framework_name(c: &mut Criterion) {
    c.bench_function("pattern_name/framework", |b| {
        // Benchmark implementation
    });
}

// Group and main at the bottom
criterion_group!(benches, benchmark_framework_name, /* ... */);
criterion_main!(benches);
```

### Naming Conventions

- **Benchmark files**: `pattern_name.rs` (snake_case)
- **Benchmark functions**: `benchmark_framework_name` (snake_case)
- **Criterion names**: `"pattern_name/framework"` (lowercase with slash)
- **Constants**: `UPPER_SNAKE_CASE`

### Comments and Documentation

```rust
// Brief description of what the benchmark tests
fn benchmark_pattern(c: &mut Criterion) {
    c.bench_function("pattern/framework", |b| {
        b.iter(|| {
            // Explain non-obvious implementation choices
            // Document any performance considerations
        })
    });
}
```

## Testing

### Running Tests

Before submitting changes:

1. **Verify benchmarks compile:**
```bash
cargo check --all-targets
```

2. **Run affected benchmarks:**
```bash
cargo bench --bench <your-benchmark>
```

3. **Run all benchmarks (if time permits):**
```bash
cargo bench -p timely-differential-benchmarks
```

### Performance Testing

When adding or modifying benchmarks:

1. Run benchmark multiple times to ensure consistency
2. Compare with baseline results if available
3. Document any significant performance changes
4. Consider different data sizes or configurations

## Commit Guidelines

### Commit Message Format

Follow conventional commits format:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code restructuring without behavior change
- `perf`: Performance improvements
- `test`: Adding or modifying tests
- `chore`: Maintenance tasks

**Examples:**

```bash
git commit -m "feat(benchmarks): add stream aggregation benchmark"

git commit -m "fix(reachability): correct edge parsing logic"

git commit -m "docs(readme): clarify benchmark execution steps"

git commit -m "perf(join): optimize hash table initialization"
```

### Commit Best Practices

- One logical change per commit
- Clear, descriptive messages
- Reference issues when applicable
- Keep commits atomic and focused

## Pull Request Process

### Before Creating a PR

1. **Update documentation:**
   - README.md if adding benchmarks
   - Inline comments for complex code
   - CONTRIBUTING.md if changing processes

2. **Format and lint:**
```bash
cargo fmt --all
cargo clippy --all-targets
```

3. **Test thoroughly:**
```bash
cargo bench --bench <affected-benchmarks>
```

4. **Review changes:**
```bash
git diff
```

### Creating a PR

1. **Branch naming:**
```bash
git checkout -b feat/stream-aggregation-benchmark
git checkout -b fix/reachability-parsing-error
git checkout -b docs/improve-setup-instructions
```

2. **PR Title:** Follow conventional commits format
```
feat(benchmarks): add stream aggregation benchmark
fix(reachability): correct edge parsing logic
docs(readme): clarify benchmark execution steps
```

3. **PR Description:** Use the structured format

```markdown
## Overview
Brief description of the changes

## Task Details
- ✅ What was changed
- ✅ What was added
- ✅ What was fixed

## Changes Made
- Specific changes with file references
- Implementation details
- Technical decisions

## Benefits
- Why this change is valuable
- Performance impact
- Maintainability improvements

## Testing
- ✅ Benchmark runs successfully
- ✅ Results are consistent
- ✅ Documentation updated

## Impact Analysis
- Affected benchmarks
- Potential performance impact
- Breaking changes (if any)
```

### PR Review Process

- PRs require review before merging
- Address feedback promptly
- Keep discussions focused and constructive
- Update PR based on review comments

## Benchmark-Specific Guidelines

### Data Files

When adding data files:
- Keep files reasonably sized (< 10MB when possible)
- Document data source and format
- Use meaningful filenames
- Consider compression for large files

### External Dependencies

When adding dependencies:
- Justify the need in commit message
- Use specific versions when possible
- Consider impact on build time
- Update documentation

### Framework Comparisons

When comparing frameworks:
- Implement equivalent algorithms
- Use fair, realistic workloads
- Document any implementation differences
- Avoid artificial optimizations

## Integration with Main Repository

This repository works alongside the main Hydroflow repository:

### Dependency References

By default, use git references:
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
```

For local development, use path references:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
```

### Synchronized Changes

When Hydroflow APIs change:
1. Update benchmark implementations
2. Test all affected benchmarks
3. Document breaking changes
4. Consider backward compatibility

## Getting Help

### Resources

- **Benchmark documentation**: `benches/README.md`
- **Repository README**: `README.md`
- **Criterion docs**: https://bheisler.github.io/criterion.rs/book/
- **Hydroflow docs**: https://github.com/hydro-project/hydro

### Questions and Discussions

- Create an issue for questions
- Use discussions for design conversations
- Tag relevant maintainers
- Be specific and provide context

## Recognition

Contributors will be:
- Acknowledged in commit history
- Mentioned in release notes (for significant contributions)
- Appreciated by the community!

Thank you for contributing to Hydroflow performance benchmarks!
