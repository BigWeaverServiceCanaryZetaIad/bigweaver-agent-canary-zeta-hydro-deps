# Setup and Execution Guide

This guide provides step-by-step instructions for setting up and running the timely and differential-dataflow benchmarks.

## Prerequisites

- Rust toolchain (1.70 or later recommended)
- Cargo (comes with Rust)
- Git

## Installation Steps

### 1. Install Rust (if not already installed)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### 2. Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### 3. Choose Dependency Configuration

You have two options for configuring dependencies on the main Hydro repository:

#### Option A: Using Git Dependencies (Simplest)

The default configuration uses git dependencies. No changes needed!

#### Option B: Using Local Path Dependencies (Faster for development)

If you want to use a local clone of the main Hydro repository:

1. Clone the main repository side-by-side:
   ```bash
   cd ..
   git clone https://github.com/hydro-project/hydro.git bigweaver-agent-canary-hydro-zeta
   ```

2. Edit `timely-differential-benches/Cargo.toml`:
   - Comment out the git dependency lines
   - Uncomment the path dependency lines

   The file should look like:
   ```toml
   # Using path dependencies:
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   
   # Git dependencies commented out:
   # dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
   # sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
   ```

## Building

Build all benchmarks:

```bash
cargo build --release
```

Note: The first build may take several minutes as it compiles timely-dataflow, differential-dataflow, and all dependencies.

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

This will run all benchmarks and save results to `target/criterion/`.

### Run Specific Benchmarks

```bash
# Individual benchmarks
cargo bench --bench arithmetic
cargo bench --bench fan_in
cargo bench --bench fan_out
cargo bench --bench fork_join
cargo bench --bench identity
cargo bench --bench join
cargo bench --bench reachability
cargo bench --bench upcase
```

### Run Specific Benchmark Functions

```bash
# Run only the pipeline benchmark in arithmetic
cargo bench --bench arithmetic -- "arithmetic/pipeline"

# Run only the differential benchmark in reachability
cargo bench --bench reachability -- "reachability/differential"
```

### Filter Benchmarks by Pattern

```bash
# Run all benchmarks containing "timely" in their name
cargo bench -- timely

# Run all benchmarks containing "dfir" in their name
cargo bench -- dfir
```

## Viewing Results

### HTML Reports

After running benchmarks, open the HTML report in your browser:

```bash
# On macOS
open target/criterion/report/index.html

# On Linux
xdg-open target/criterion/report/index.html

# On Windows
start target/criterion/report/index.html
```

### Command Line Output

Criterion prints summary statistics to the console after each benchmark run:
- Time per iteration
- Change from previous run (if available)
- Performance outliers
- Statistical confidence intervals

### Comparing Results

Criterion automatically compares results with previous runs. To force a baseline:

```bash
# Save current results as baseline
cargo bench -- --save-baseline my-baseline

# Compare against the baseline
cargo bench -- --baseline my-baseline
```

## Troubleshooting

### Build Errors

**Problem**: Compilation errors about missing dependencies
**Solution**: Ensure you're using Rust 1.70 or later:
```bash
rustc --version
rustup update
```

**Problem**: Cannot find `dfir_rs` or `sinktools`
**Solution**: 
- If using git dependencies: Check your internet connection
- If using path dependencies: Ensure the main Hydro repository is cloned in the correct location

### Performance Issues

**Problem**: Benchmarks take too long
**Solution**: Reduce sample size or warm-up time in the benchmark code, or run specific benchmarks instead of all at once

**Problem**: Inconsistent results
**Solution**: 
- Close other applications
- Run on a quiet system
- Increase sample size for more stable results

### Runtime Errors

**Problem**: `reachability` benchmark fails
**Solution**: Ensure `reachability_edges.txt` and `reachability_reachable.txt` are in the `benches/` directory

**Problem**: `fork_join` benchmark fails
**Solution**: Ensure `build.rs` ran successfully and generated `fork_join_20.hf`

## Development Workflow

### Adding a New Benchmark

1. Create a new file in `timely-differential-benches/benches/`, e.g., `my_benchmark.rs`

2. Add the benchmark declaration to `timely-differential-benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```

3. Implement your benchmark using the criterion framework:
   ```rust
   use criterion::{criterion_group, criterion_main, Criterion};
   
   fn my_benchmark(c: &mut Criterion) {
       c.bench_function("my_benchmark/test", |b| {
           b.iter(|| {
               // Your benchmark code here
           });
       });
   }
   
   criterion_group!(benches, my_benchmark);
   criterion_main!(benches);
   ```

4. Run your benchmark:
   ```bash
   cargo bench --bench my_benchmark
   ```

### Modifying Existing Benchmarks

1. Edit the benchmark file in `timely-differential-benches/benches/`
2. Rebuild and run:
   ```bash
   cargo bench --bench <benchmark_name>
   ```

### Testing Changes

Before committing changes:

1. Ensure all benchmarks compile:
   ```bash
   cargo check
   ```

2. Run a quick sanity check:
   ```bash
   cargo bench --bench arithmetic -- --quick
   ```

## Performance Tips

- **Use release builds**: Always use `cargo bench` (which uses release mode) instead of `cargo test`
- **Warm up the system**: Run benchmarks multiple times and use later runs for comparison
- **Consistent environment**: Run benchmarks on the same machine with similar load
- **Sufficient iterations**: Criterion automatically adjusts, but you can override in the code
- **Statistical significance**: Look at the confidence intervals in the output

## Additional Resources

- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow Documentation](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow Documentation](https://github.com/TimelyDataflow/differential-dataflow)
- [Main Hydro Repository](https://github.com/hydro-project/hydro)

## Getting Help

- Check the [timely-differential-benches README](timely-differential-benches/README.md) for detailed benchmark information
- Review the [main repository README](README.md) for project overview
- Open an issue in the repository for bugs or questions
