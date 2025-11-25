# Contributing to Hydro-Deps Benchmarks

Thank you for your interest in contributing to the hydro-deps benchmarks repository! This document provides guidelines for contributing.

## Getting Started

### Prerequisites

1. **Rust**: Install the latest stable Rust toolchain
2. **Main Repository**: Clone the main `bigweaver-agent-canary-hydro-zeta` repository as a sibling directory
3. **Git**: Familiarity with Git and GitHub workflows

### Repository Structure

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/     # Main repository (required)
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

## Types of Contributions

### 1. Adding New Benchmarks

When adding a new benchmark that uses timely or differential-dataflow:

1. **Create the benchmark file** in `benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   use timely::dataflow::operators::*;
   // or
   use differential_dataflow::operators::*;
   
   fn your_benchmark(c: &mut Criterion) {
       c.bench_function("category/name", |b| {
           // benchmark code
       });
   }
   
   criterion_group!(benches, your_benchmark);
   criterion_main!(benches);
   ```

2. **Register in Cargo.toml**:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

3. **Document the benchmark**:
   - Add description to README.md
   - Update BENCHMARK_GUIDE.md with usage details
   - Include comments in the benchmark file

4. **Test the benchmark**:
   ```bash
   cargo build --bench your_benchmark
   cargo bench --bench your_benchmark
   ```

### 2. Updating Existing Benchmarks

When modifying existing benchmarks:

1. **Understand the current implementation**
2. **Make your changes**
3. **Test thoroughly**:
   ```bash
   # Save baseline before changes
   cargo bench -- --save-baseline before
   
   # Make changes
   
   # Compare after changes
   cargo bench -- --baseline before
   ```
4. **Update documentation** if behavior changes
5. **Note performance impacts** in your PR description

### 3. Updating Dependencies

When updating timely or differential-dataflow versions:

1. **Update Cargo.toml** with new versions
2. **Run cargo update**
3. **Test all benchmarks**:
   ```bash
   cargo build --benches
   cargo bench
   ```
4. **Check for breaking changes** in the dependency APIs
5. **Update code** if necessary
6. **Document changes** in CHANGELOG.md

### 4. Improving Documentation

Documentation improvements are always welcome:

- Fix typos or unclear explanations
- Add examples or clarifications
- Improve command references
- Add troubleshooting tips

## Development Workflow

### Setting Up Your Environment

```bash
# Clone repositories
cd parent-directory
git clone <main-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <this-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Navigate to this repository
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify setup
./verify_setup.sh

# Build benchmarks
cargo build --benches
```

### Making Changes

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

3. **Test your changes**:
   ```bash
   ./verify_setup.sh
   cargo check --benches
   cargo build --benches
   cargo bench
   ```

4. **Commit your changes** following conventional commits:
   ```bash
   git add .
   git commit -m "feat(benchmarks): add new benchmark for X"
   ```

### Commit Message Format

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(benchmarks): add stream aggregation benchmark
fix(reachability): correct graph data loading
docs(readme): improve quick start guide
perf(arithmetic): optimize pipeline implementation
```

### Creating Pull Requests

1. **Push your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create PR** on GitHub

3. **PR Title**: Use conventional commit format
   ```
   feat(benchmarks): add new join pattern benchmark
   ```

4. **PR Description** should include:
   - What changes were made
   - Why the changes were needed
   - How to test the changes
   - Performance impact (if applicable)
   - Related issues (if any)

5. **PR Template**:
   ```markdown
   ## Description
   Brief description of changes
   
   ## Changes Made
   - Added/Modified/Removed X
   - Updated Y
   
   ## Testing
   - [ ] ./verify_setup.sh passes
   - [ ] cargo build --benches succeeds
   - [ ] cargo bench runs successfully
   - [ ] Documentation updated
   
   ## Performance Impact
   Describe any performance changes
   
   ## Related Issues
   Fixes #123
   ```

## Code Style and Standards

### Rust Code

- Follow standard Rust formatting: `cargo fmt`
- Pass clippy lints: `cargo clippy --benches`
- Use meaningful variable names
- Add comments for complex logic
- Include docstrings for public functions

### Benchmark Code

- Use `black_box()` to prevent unwanted optimizations
- Include multiple implementation comparisons where applicable
- Use realistic data sizes
- Document constants and parameters
- Include warmup phases

### Documentation

- Use clear, concise language
- Provide examples
- Keep formatting consistent
- Update all affected docs

## Testing

### Required Tests

Before submitting:

```bash
# 1. Verify setup
./verify_setup.sh

# 2. Check compilation
cargo check --benches

# 3. Build all benchmarks
cargo build --benches

# 4. Run benchmarks
cargo bench

# 5. Check for regressions
cargo bench -- --baseline main
```

### Benchmark Validation

- Ensure benchmarks produce consistent results
- Verify performance characteristics are expected
- Check that comparisons are meaningful
- Test with different data sizes if applicable

## Review Process

1. **Automated checks** run on PR creation
2. **Maintainer review** for code quality and design
3. **Performance review** for benchmark changes
4. **Documentation review** for completeness
5. **Approval and merge**

## Coordination with Main Repository

When changes affect both repositories:

1. **Create PRs in both repositories**
2. **Reference each other** in PR descriptions
3. **Coordinate merging** to avoid breakage
4. **Test cross-repository compatibility**

Example:
```markdown
This PR is part of a coordinated change with:
- Main repo PR: BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta#123
```

## Questions and Support

- **Issues**: Open a GitHub issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check BENCHMARK_GUIDE.md and other docs first

## Code of Conduct

- Be respectful and constructive
- Follow community guidelines
- Help others learn and grow
- Maintain a welcoming environment

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (Apache-2.0).

## Thank You!

Your contributions help improve the benchmark suite and the entire project. Thank you for taking the time to contribute!
