# Contributing to bigweaver-agent-canary-zeta-hydro-deps

Thanks for your interest in contributing to this repository! This guide will explain the repository structure, code style, and how to contribute benchmarks.

## Repository Purpose

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow. These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. Keep the main codebase lightweight and free from heavy dependencies
2. Enable performance comparisons between Hydro/DFIR and timely/differential implementations
3. Maintain the ability to run comprehensive benchmarks across different dataflow frameworks

## Repository Structure

The repository is organized as a Cargo workspace with the following structure:

* `benches/` - Contains all benchmark code
  * `benches/benches/` - Individual benchmark files (`.rs`) and data files (`.txt`)
  * `benches/Cargo.toml` - Package manifest defining dependencies and benchmark targets
  * `benches/build.rs` - Build script for generating benchmark code
  * `benches/README.md` - Detailed documentation for each benchmark

## Rust Toolchain

This repository uses the same Rust toolchain as the main Hydro repository (currently 1.91.1). The version is specified in `rust-toolchain.toml` and is automatically detected by `cargo`.

## Code Quality Standards

This repository follows the same code quality standards as the main Hydro repository:

### Formatting
Run `cargo fmt` to format code according to the style defined in `rustfmt.toml`:
```shell
cargo fmt
```

### Linting
Run `cargo clippy` to check for common issues:
```shell
cargo clippy --all-targets
```

Configuration is defined in `clippy.toml` and workspace lints in `Cargo.toml`.

## Adding New Benchmarks

To add a new benchmark to this repository:

1. **Create the benchmark file**
   - Add a new `.rs` file to `benches/benches/`
   - Follow the existing benchmark structure
   - Use Criterion for benchmarking framework
   - Include both timely/differential and DFIR implementations for comparison

2. **Update Cargo.toml**
   - Add a new `[[bench]]` section to `benches/Cargo.toml`:
     ```toml
     [[bench]]
     name = "my_benchmark"
     harness = false
     ```

3. **Add data files if needed**
   - Place any required data files in `benches/benches/`
   - Use `include_bytes!()` to embed files in the benchmark

4. **Update documentation**
   - Add a description of your benchmark to `benches/README.md`
   - Include purpose, implementations, and any special considerations

5. **Test the benchmark**
   ```shell
   # Build the benchmark
   cargo build --release -p hydro-timely-differential-benches --bench my_benchmark
   
   # Run the benchmark
   cargo bench -p hydro-timely-differential-benches --bench my_benchmark
   ```

6. **Format and lint**
   ```shell
   cargo fmt
   cargo clippy --all-targets
   ```

## Benchmark Guidelines

When writing benchmarks:

1. **Compare implementations fairly**
   - Ensure timely, differential, and DFIR implementations solve the same problem
   - Use equivalent data structures and algorithms
   - Avoid optimizations that favor one implementation over others

2. **Use appropriate data sizes**
   - Choose data sizes that are representative of real workloads
   - Ensure benchmarks complete in reasonable time (seconds, not minutes)
   - Consider using `criterion`'s parameter scaling for multiple sizes

3. **Document the benchmark**
   - Explain what the benchmark measures
   - Document any assumptions or limitations
   - Include references to papers or documentation if implementing known algorithms

4. **Minimize noise**
   - Use `black_box()` from criterion to prevent compiler optimizations
   - Avoid I/O operations in hot paths
   - Use appropriate warmup and measurement iterations

## Submitting Changes

### Commit Messages

Follow [Conventional Commits specification](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]

[optional footer]
```

Common types:
- `feat`: New benchmark or feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test improvements
- `chore`: Maintenance tasks

Examples:
```
feat(benchmarks): add graph coloring benchmark

Add a new benchmark comparing graph coloring algorithms across
timely, differential, and DFIR implementations.
```

```
fix(reachability): correct edge loading logic

The edge file parsing was incorrectly handling empty lines.
```

### Pull Requests

When creating a pull request:

1. **Title**: Use conventional commit format
   - Example: `feat(benchmarks): add new streaming join benchmark`

2. **Description**: Include the following sections:
   - **Description**: High-level overview of changes
   - **Changes Made**: Bullet points of specific changes
   - **Why Changes Are Necessary**: Justification and context
   - **How to Use**: Instructions for running/testing new benchmarks
   - **Verification**: How you tested the changes
   - **Related Changes**: Links to related PRs or issues

3. **Testing**: Ensure all benchmarks build and run:
   ```shell
   cargo build --release -p hydro-timely-differential-benches
   cargo bench -p hydro-timely-differential-benches
   ```

4. **Code Quality**: Run formatting and linting:
   ```shell
   cargo fmt
   cargo clippy --all-targets
   ```

## Coordinated Changes

This repository may require coordinated changes with the main Hydro repository. When making such changes:

1. Create companion PRs in both repositories
2. Clearly indicate merge order in PR descriptions
3. Reference companion PRs using GitHub links
4. Ensure both PRs are reviewed before merging

Example note in PR description:
```
## Related Changes

Companion PR in main repository: [Link to PR]

**IMPORTANT - Merge Order**: This PR should be merged FIRST before the companion PR.
```

## Dependencies

This repository depends on:

- **timely-dataflow**: Low-level dataflow framework
- **differential-dataflow**: Incremental computation on timely
- **dfir_rs**: Via git dependency to main Hydro repository
- **sinktools**: Via git dependency to main Hydro repository
- **criterion**: Benchmarking framework

When updating dependencies:
1. Consider impact on benchmark results (may need re-baselining)
2. Update `Cargo.toml` with specific version requirements
3. Document significant dependency changes in PR

## Testing

### Local Testing

```shell
# Build all benchmarks
cargo build --release -p hydro-timely-differential-benches

# Run all benchmarks
cargo bench -p hydro-timely-differential-benches

# Run specific benchmark
cargo bench -p hydro-timely-differential-benches --bench reachability

# Format code
cargo fmt

# Lint code
cargo clippy --all-targets
```

### Verification

Before submitting:

1. ✅ All benchmarks build successfully
2. ✅ All benchmarks run without errors
3. ✅ Code is formatted (`cargo fmt`)
4. ✅ No clippy warnings (`cargo clippy`)
5. ✅ Documentation is updated
6. ✅ Commit messages follow conventional commits

## Related Documentation

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Benchmark Migration Documentation](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## Questions?

If you have questions or need help:
1. Check the [benches/README.md](benches/README.md) for benchmark-specific information
2. Review existing benchmarks for examples
3. Open an issue for discussion before making large changes
