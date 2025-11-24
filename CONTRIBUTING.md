# Contributing to Hydro Dependencies Benchmarks

Thank you for your interest in contributing to the Hydro benchmarks! This document provides guidelines for contributing to this repository.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and collaborative environment.

## How to Contribute

### Reporting Issues

If you encounter bugs or have suggestions for improvements:

1. Check if the issue already exists in the issue tracker
2. Create a new issue with a clear title and description
3. Include relevant information:
   - Benchmark name
   - Error messages or unexpected behavior
   - System information (OS, Rust version)
   - Steps to reproduce

### Adding New Benchmarks

To add a new benchmark:

1. **Create the benchmark file**:
   ```bash
   cd benches/benches
   touch your_benchmark.rs
   ```

2. **Implement the benchmark**:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn benchmark_dfir(c: &mut Criterion) {
       c.bench_function("your_benchmark/dfir", |b| {
           // Your DFIR implementation
       });
   }
   
   fn benchmark_timely(c: &mut Criterion) {
       c.bench_function("your_benchmark/timely", |b| {
           // Your timely implementation
       });
   }
   
   fn benchmark_differential(c: &mut Criterion) {
       c.bench_function("your_benchmark/differential", |b| {
           // Your differential implementation
       });
   }
   
   criterion_group!(benches, benchmark_dfir, benchmark_timely, benchmark_differential);
   criterion_main!(benches);
   ```

3. **Add to Cargo.toml**:
   ```toml
   [[bench]]
   name = "your_benchmark"
   harness = false
   ```

4. **Test the benchmark**:
   ```bash
   cargo bench -p benches --bench your_benchmark
   ```

5. **Update documentation**:
   - Add description to main README.md
   - Update QUICK_START.md if needed
   - Add entry to CHANGES.md

### Improving Existing Benchmarks

When modifying existing benchmarks:

1. Ensure changes don't break performance comparison capabilities
2. Maintain implementations for all three frameworks (DFIR, timely, differential)
3. Update comments and documentation
4. Run benchmarks before and after changes to verify impact
5. Include performance comparison in your pull request

### Adding Test Data

If your benchmark requires test data:

1. Keep data files reasonably sized (prefer < 5MB)
2. Document the source and format of data
3. Add data files to `benches/benches/`
4. Update `.gitignore` if needed for generated files
5. Credit data sources in README.md

## Development Workflow

### Setting Up Development Environment

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the project
cargo build -p benches

# Run tests
cargo test -p benches

# Run benchmarks
cargo bench -p benches
```

### Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b add-your-feature-$(date +%Y%m%d-%H%M%S)
   ```

2. **Make your changes**:
   - Write clear, documented code
   - Follow Rust coding conventions
   - Add tests where appropriate

3. **Test your changes**:
   ```bash
   cargo test -p benches
   cargo bench -p benches --bench your_benchmark
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat(benches): add your feature description"
   ```

## Commit Message Guidelines

Follow the Conventional Commits specification:

Format: `type(scope): description`

**Types**:
- `feat`: New feature or benchmark
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Adding or updating tests
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `chore`: Maintenance tasks

**Examples**:
```
feat(benches): add graph coloring benchmark
fix(reachability): correct edge processing logic
docs(readme): update benchmark descriptions
perf(join): optimize hash join implementation
```

## Pull Request Process

1. **Create a pull request** with a clear title and description

2. **PR Title Format**:
   ```
   feat(benches): add new benchmark for X
   ```

3. **PR Description Template**:
   ```markdown
   ## Overview
   Brief description of the changes
   
   ## Task Details
   - ✅ Created new benchmark
   - ✅ Added test data
   - ✅ Updated documentation
   
   ## Changes Made
   ### Added
   - List new files or features
   
   ### Modified
   - List modified files
   
   ## Benefits
   - ✅ Benefit 1
   - ✅ Benefit 2
   
   ## Testing
   - ✅ Benchmark runs successfully
   - ✅ Results are consistent
   - ✅ Documentation updated
   
   ## Performance Impact
   Include benchmark results showing:
   - Execution times
   - Comparison with other implementations
   - Any performance insights
   ```

4. **Address review feedback** promptly and professionally

5. **Ensure CI passes** (if applicable)

## Code Style Guidelines

### Rust Code

- Follow standard Rust formatting (`rustfmt`)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and reasonably sized
- Handle errors appropriately

### Documentation

- Write clear, concise documentation
- Include examples where helpful
- Update README files when adding features
- Keep CHANGES.md up to date

### Benchmarks

- Name benchmarks descriptively
- Include context in benchmark names (e.g., "join/dfir/small_dataset")
- Document what each benchmark measures
- Provide meaningful comparison points

## Testing

### Running Tests

```bash
# Run all tests
cargo test -p benches

# Run specific test
cargo test -p benches test_name

# Run with output
cargo test -p benches -- --nocapture
```

### Benchmark Testing

```bash
# Quick test
cargo bench -p benches --bench your_benchmark -- --quick

# Full benchmark
cargo bench -p benches --bench your_benchmark

# Profile mode
cargo bench -p benches --bench your_benchmark -- --profile-time=60
```

## Repository Structure

```
.
├── benches/                    # Benchmark crate
│   ├── benches/               # Benchmark implementations
│   ├── src/                   # Source files
│   ├── Cargo.toml            # Dependencies
│   └── README.md             # Benchmark documentation
├── Cargo.toml                 # Workspace configuration
├── README.md                  # Main documentation
├── QUICK_START.md            # Getting started guide
├── CONTRIBUTING.md           # This file
├── CHANGES.md                # Changelog
└── .gitignore                # Git ignore rules
```

## Benchmark Best Practices

1. **Fair Comparisons**:
   - Use equivalent algorithms across frameworks
   - Ensure similar optimization levels
   - Use comparable data structures

2. **Meaningful Metrics**:
   - Measure what matters (throughput, latency, memory)
   - Use realistic input sizes
   - Consider different scenarios (hot/cold cache, etc.)

3. **Statistical Validity**:
   - Let criterion handle iterations
   - Run benchmarks multiple times
   - Report confidence intervals

4. **Reproducibility**:
   - Document system configuration
   - Fix random seeds where appropriate
   - Include version information

## Resources

- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Timely Dataflow Documentation](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow Documentation](https://timelydataflow.github.io/differential-dataflow/)

## Questions?

If you have questions about contributing:

1. Check existing issues and discussions
2. Review the main Hydro repository documentation
3. Create an issue with your question

## License

By contributing to this project, you agree that your contributions will be licensed under the Apache-2.0 License.

## Thank You!

Your contributions help make Hydro better. We appreciate your time and effort! 🙏
