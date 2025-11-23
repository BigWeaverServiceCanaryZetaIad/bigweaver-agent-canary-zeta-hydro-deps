# Quick Start Guide

This guide will help you get up and running with the Hydroflow external dependency benchmarks quickly.

## Prerequisites

Before you begin, ensure you have:

1. **Rust Toolchain**: Install from [rustup.rs](https://rustup.rs/)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Git**: For cloning and dependency resolution

3. **Network Access**: To fetch dependencies from git repositories

## Installation

### Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Verify Setup

Check that everything compiles:

```bash
cargo check -p hydro-deps-benches
```

This will download all dependencies and verify the build configuration.

## Running Your First Benchmark

### Quick Test Run

Run a single benchmark in quick mode to verify everything works:

```bash
./run_benchmarks.sh --bench arithmetic --quick
```

Or using cargo directly:

```bash
cargo bench -p hydro-deps-benches --bench arithmetic -- --quick
```

### Run All Benchmarks

To run the complete benchmark suite:

```bash
./run_benchmarks.sh
```

Or:

```bash
cargo bench -p hydro-deps-benches
```

**Note**: Running all benchmarks can take significant time (10-30 minutes depending on your hardware).

## Understanding Results

After running benchmarks, you'll see output like:

```
arithmetic/pipeline     time:   [1.2345 ms 1.2567 ms 1.2789 ms]
                        change: [-2.3456% -1.2345% -0.1234%] (p = 0.05 < 0.05)
                        Performance has improved.
```

This tells you:
- **time**: The measured execution time (lower is better)
- **change**: Performance change compared to previous run
- **p-value**: Statistical significance

### View Detailed Reports

Open the HTML report for detailed analysis:

```bash
# On Linux
xdg-open target/criterion/report/index.html

# On macOS
open target/criterion/report/index.html

# On Windows
start target/criterion/report/index.html
```

The HTML reports include:
- Performance graphs
- Statistical analysis
- Comparison with previous runs
- Detailed timing breakdowns

## Common Use Cases

### Compare Specific Implementations

Each benchmark typically tests multiple implementations. Look for results like:

- `arithmetic/hydroflow` - Hydroflow implementation
- `arithmetic/timely` - Timely dataflow implementation
- `arithmetic/differential` - Differential dataflow implementation

### Run Benchmarks for Development

When working on performance improvements:

1. **Create a baseline**:
   ```bash
   ./run_benchmarks.sh --save before-optimization
   ```

2. **Make your changes** to the code

3. **Compare results**:
   ```bash
   ./run_benchmarks.sh --compare before-optimization
   ```

This shows exactly how your changes affected performance.

### Run Individual Benchmarks

To focus on a specific benchmark:

```bash
# Arithmetic operations
./run_benchmarks.sh --bench arithmetic

# Graph reachability
./run_benchmarks.sh --bench reachability

# Join operations
./run_benchmarks.sh --bench join
```

## Available Benchmarks

| Benchmark | Description | Typical Runtime |
|-----------|-------------|-----------------|
| `arithmetic` | Arithmetic pipeline operations | ~2 minutes |
| `fan_in` | Multiple streams to one | ~2 minutes |
| `fan_out` | One stream to multiple | ~2 minutes |
| `fork_join` | Split and merge pattern | ~3 minutes |
| `identity` | Pass-through operations | ~2 minutes |
| `join` | Hash join operations | ~3 minutes |
| `reachability` | Graph algorithms | ~5 minutes |
| `upcase` | String transformations | ~2 minutes |

**Total time for all benchmarks**: 15-25 minutes

## Troubleshooting

### Build Errors

**Problem**: `error: failed to fetch...`

**Solution**: Ensure you have network access and git is configured:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Problem**: `error: package 'dfir_rs' not found`

**Solution**: The benchmark needs access to the main repository. Check network connectivity and git credentials.

### Performance Issues

**Problem**: Benchmarks take too long

**Solution**: Use quick mode for faster iteration:
```bash
./run_benchmarks.sh --quick
```

**Problem**: High variance in results

**Solution**: 
1. Close other applications
2. Run on a less busy system
3. Use a dedicated benchmark machine
4. Disable CPU frequency scaling

### Permission Errors

**Problem**: `Permission denied` when running scripts

**Solution**:
```bash
chmod +x run_benchmarks.sh
```

## Next Steps

Now that you have benchmarks running:

1. **Explore the Documentation**: Read `benches/README.md` for detailed benchmark descriptions

2. **Understand the Code**: Look at individual benchmark files in `benches/benches/`

3. **Run Experiments**: Try different configurations and compare results

4. **Contribute**: See `CONTRIBUTING.md` for guidelines on adding new benchmarks

## Useful Commands

### Development Workflow

```bash
# Check code compiles
cargo check -p hydro-deps-benches

# Format code
cargo fmt --all

# Run linter
cargo clippy --all-targets

# Run quick benchmark test
./run_benchmarks.sh --bench arithmetic --quick

# View benchmark list
./run_benchmarks.sh --list
```

### Benchmark Analysis

```bash
# Save baseline before changes
./run_benchmarks.sh --save baseline

# After changes, compare
./run_benchmarks.sh --compare baseline

# Run specific benchmark in detail
cargo bench -p hydro-deps-benches --bench reachability -- --verbose
```

## Getting Help

If you run into issues:

1. **Check Documentation**: Review `README.md` and `benches/README.md`
2. **Search Issues**: Look for similar issues on GitHub
3. **Ask Questions**: Open an issue for help
4. **Community**: Reach out to the Hydroflow community

## Resources

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## Summary

You now know how to:
- ✅ Set up the benchmark environment
- ✅ Run individual and complete benchmark suites
- ✅ Understand benchmark results
- ✅ Compare performance across implementations
- ✅ Use baselines for tracking changes
- ✅ Access detailed HTML reports

Happy benchmarking! 🚀
