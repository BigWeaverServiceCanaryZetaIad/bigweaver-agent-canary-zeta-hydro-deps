# Quick Start Guide

This guide will help you get started with the timely and differential-dataflow benchmarks quickly.

## Prerequisites

Ensure you have the following installed:

- **Rust**: Latest stable version (1.70+)
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```
- **Cargo**: Comes with Rust installation
- **Git**: For cloning the repository

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 2. Build the Project

```bash
cargo build -p hydro-deps-benches
```

This will:
- Download and compile all dependencies
- Run the build script to generate necessary code
- Prepare the benchmarks for execution

### 3. Run All Benchmarks

```bash
cargo bench -p hydro-deps-benches
```

This will execute all 8 benchmarks and generate HTML reports in `target/criterion/`.

## Running Specific Benchmarks

### Individual Benchmarks

Run a single benchmark:

```bash
# Timely-dataflow benchmarks
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench fan_in
cargo bench -p hydro-deps-benches --bench fan_out
cargo bench -p hydro-deps-benches --bench fork_join
cargo bench -p hydro-deps-benches --bench identity
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench upcase

# Differential-dataflow benchmark
cargo bench -p hydro-deps-benches --bench reachability
```

### Filter Specific Tests

Run specific test cases within a benchmark:

```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- pipeline
cargo bench -p hydro-deps-benches --bench reachability -- differential
```

## Viewing Results

### Console Output

Benchmark results are printed to the console showing:
- Execution time (mean, median, std dev)
- Comparison with previous runs (if available)
- Throughput measurements

Example output:
```
arithmetic/pipeline     time:   [152.34 ms 153.21 ms 154.15 ms]
                        change: [-2.1234% -1.5678% -0.9876%] (p = 0.00 < 0.05)
                        Performance has improved.
```

### HTML Reports

Detailed HTML reports are generated in:
```
target/criterion/<benchmark_name>/report/index.html
```

Open these files in a web browser for:
- Detailed statistics
- Performance graphs
- Historical comparisons
- Violin plots

### Viewing Reports

```bash
# On Linux
xdg-open target/criterion/arithmetic/report/index.html

# On macOS
open target/criterion/arithmetic/report/index.html

# On Windows
start target/criterion/arithmetic/report/index.html
```

## Common Use Cases

### Establishing a Baseline

Create a baseline for comparison:

```bash
cargo bench -p hydro-deps-benches -- --save-baseline my-baseline
```

### Comparing Against Baseline

Compare current performance against a baseline:

```bash
cargo bench -p hydro-deps-benches -- --baseline my-baseline
```

### Quick Performance Check

Run benchmarks with reduced sample size for faster feedback:

```bash
cargo bench -p hydro-deps-benches -- --sample-size 10
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update Rust**:
   ```bash
   rustup update
   ```

2. **Clean and rebuild**:
   ```bash
   cargo clean
   cargo build -p hydro-deps-benches
   ```

3. **Check dependencies**:
   ```bash
   cargo tree -p hydro-deps-benches
   ```

### Missing dfir_rs or sinktools

Some benchmarks depend on `dfir_rs` and `sinktools` from the main repository. To use these:

1. Clone the main repository alongside this one:
   ```bash
   cd ..
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   ```

2. Update `benches/Cargo.toml` to uncomment the path dependencies:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

### Long Running Benchmarks

Some benchmarks (especially `reachability`) may take several minutes. This is normal. Use `--sample-size` to reduce runtime during development:

```bash
cargo bench -p hydro-deps-benches --bench reachability -- --sample-size 10
```

## Next Steps

- Read [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for detailed information about each benchmark
- See [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md) for integration with the main repository
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding new benchmarks

## Performance Testing Workflow

For the Performance Testing Team:

1. **Establish baseline** before making changes
2. **Run benchmarks** after changes
3. **Compare results** using Criterion's built-in comparison
4. **Document findings** in performance reports
5. **Share results** with the Development Team

Example workflow:
```bash
# Before changes
cargo bench -p hydro-deps-benches -- --save-baseline before-optimization

# After changes
cargo bench -p hydro-deps-benches -- --baseline before-optimization

# Review the HTML reports for detailed comparisons
```

## Support

For questions or issues:
- Check the main [README.md](README.md)
- Review the [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md)
- Contact the Performance Testing Team
- Open an issue in the repository

---

**Quick Reference**:
- Build: `cargo build -p hydro-deps-benches`
- Run all: `cargo bench -p hydro-deps-benches`
- Run one: `cargo bench -p hydro-deps-benches --bench <name>`
- Reports: `target/criterion/*/report/index.html`
