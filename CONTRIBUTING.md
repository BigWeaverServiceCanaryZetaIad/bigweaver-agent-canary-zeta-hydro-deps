# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thank you for your interest in contributing to the Hydro benchmarks repository!

## Overview

This repository contains benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow. It is a companion repository to [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro).

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Check that benchmarks compile:**
   ```bash
   cargo check -p benches
   ```

3. **Run benchmarks to verify functionality:**
   ```bash
   cargo bench -p benches --bench identity
   ```

## How to Contribute

### Adding New Benchmarks

When adding a new benchmark that uses `timely` or `differential-dataflow`:

1. **Create the benchmark file** in `benches/benches/`:
   ```rust
   use criterion::{Criterion, criterion_group, criterion_main};
   use timely::dataflow::operators::{ToStream, Inspect};
   
   fn benchmark_name(c: &mut Criterion) {
       c.bench_function("name/timely", |b| {
           // benchmark implementation
       });
   }
   
   criterion_group!(benches, benchmark_name);
   criterion_main!(benches);
   ```

2. **Add the benchmark to Cargo.toml**:
   ```toml
   [[bench]]
   name = "your_benchmark_name"
   harness = false
   ```

3. **Update documentation**:
   - Add entry to `benches/README.md`
   - Document any new data files or dependencies

4. **Test the benchmark**:
   ```bash
   cargo bench -p benches --bench your_benchmark_name
   ```

### Modifying Existing Benchmarks

1. Make your changes to the benchmark file
2. Verify the benchmark still compiles: `cargo check -p benches`
3. Run the benchmark to ensure it works: `cargo bench -p benches --bench <name>`
4. Document any changes in behavior or requirements

### Adding Benchmark Data Files

If your benchmark requires data files:

1. Place data files in `benches/benches/`
2. Use `include_bytes!()` or `include_str!()` to embed them
3. Document the data source and format in `benches/README.md`
4. Consider file size - large files should be justified

### Code Style

This repository follows the Rust style guidelines from the main Hydro project:

- **Formatting**: Run `cargo fmt` before committing
- **Linting**: Address `cargo clippy` warnings
- **Documentation**: Add doc comments for complex benchmark setups

### Testing Your Changes

Before submitting a PR:

1. **Verify compilation:**
   ```bash
   cargo check -p benches
   ```

2. **Run clippy:**
   ```bash
   cargo clippy -p benches
   ```

3. **Format code:**
   ```bash
   cargo fmt --all
   ```

4. **Run affected benchmarks:**
   ```bash
   cargo bench -p benches --bench <name>
   ```

## Pull Request Process

1. **Create a feature branch**:
   ```bash
   git checkout -b add-benchmark-name
   ```

2. **Make your changes** following the guidelines above

3. **Commit with a clear message**:
   ```bash
   git commit -m "feat(benches): add benchmark for X pattern"
   ```
   
   Follow [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat`: New benchmark or feature
   - `fix`: Bug fix in existing benchmark
   - `docs`: Documentation updates
   - `chore`: Maintenance tasks

4. **Push to your fork** and create a Pull Request

5. **PR Description should include**:
   - Summary of changes
   - Motivation for the benchmark/change
   - Any performance observations
   - Link to related issues or main repository PRs

### PR Title Format

Use clear, descriptive titles:
- `feat(benches): add graph algorithm benchmark`
- `fix(reachability): correct edge loading logic`
- `docs: update benchmark running instructions`

## Coordinating with Main Repository

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository:

1. **When main repository APIs change**, benchmarks may need updates
2. **Test against main repo changes** by updating git dependencies
3. **Cross-reference PRs** if changes span both repositories

## Questions and Discussions

- Open an issue for questions or discussions
- Reference the main Hydro repository for core functionality questions
- Tag maintainers for urgent issues

## Code of Conduct

Please note that this project follows the same Code of Conduct as the main Hydro project. By participating, you are expected to uphold this code.

## License

By contributing, you agree that your contributions will be licensed under the Apache-2.0 License.
