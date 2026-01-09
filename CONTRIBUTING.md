# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains comparative benchmarks for DFIR against timely-dataflow and differential-dataflow. For general contribution guidelines, please refer to the main repository's [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).

## Repository Setup

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository. Both repositories should be cloned at the same level:

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Adding New Benchmarks

When adding new comparative benchmarks:

1. Add your benchmark file to `benches/benches/`
2. Register the benchmark in `benches/Cargo.toml` with a `[[bench]]` entry
3. Ensure your benchmark includes comparisons with:
   - DFIR implementation
   - timely-dataflow implementation (if applicable)
   - differential-dataflow implementation (if applicable)
4. Update `benches/README.md` to document the new benchmark

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench <benchmark_name>

# Run with more iterations for more precise results
cargo bench -- --sample-size 100
```

## Benchmark Structure

Each benchmark should:
- Compare equivalent functionality across frameworks
- Use consistent input sizes and parameters
- Report results using criterion's standard format
- Include comments explaining what is being measured

## Code Style

Follow the same Rust style guidelines as the main repository:
- Use `rustfmt` for formatting
- Address `clippy` warnings
- Follow conventional commit messages

## Performance Considerations

- Benchmarks should be deterministic when possible
- Avoid external I/O in benchmark loops
- Use `black_box` to prevent compiler optimizations from skewing results
- Document any known performance limitations or caveats
