# Quick Start Guide

Get started with timely and differential-dataflow benchmarks in minutes.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. **Ensure you have Rust installed:**
   The project uses the Rust toolchain specified in `rust-toolchain.toml`. Rustup will automatically install the correct version.

## Running Your First Benchmark

### Run a simple benchmark:

```bash
cargo bench -p timely-differential-benchmarks --bench arithmetic
```

This will:
- Compile the benchmark code
- Execute the arithmetic benchmark
- Generate HTML reports in `target/criterion/`

### View Results:

```bash
# Results are saved to:
open target/criterion/report/index.html
```

## Running All Benchmarks

To run the complete benchmark suite:

```bash
cargo bench -p timely-differential-benchmarks
```

This will take several minutes to complete all benchmarks.

## Common Use Cases

### 1. Test Specific Dataflow Pattern

```bash
# Test fan-in pattern
cargo bench -p timely-differential-benchmarks --bench fan_in

# Test fan-out pattern
cargo bench -p timely-differential-benchmarks --bench fan_out

# Test join operations
cargo bench -p timely-differential-benchmarks --bench join
```

### 2. Test Differential Dataflow

```bash
# Run the reachability benchmark (uses differential dataflow)
cargo bench -p timely-differential-benchmarks --bench reachability
```

### 3. Compare Performance Over Time

```bash
# Run benchmarks and save baseline
cargo bench -p timely-differential-benchmarks -- --save-baseline main

# Make changes to code...

# Run benchmarks again and compare
cargo bench -p timely-differential-benchmarks -- --baseline main
```

## Benchmark List

| Benchmark | Type | Description |
|-----------|------|-------------|
| arithmetic | Timely | Arithmetic operations through dataflow |
| fan_in | Timely | Multiple inputs to single output |
| fan_out | Timely | Single input to multiple outputs |
| fork_join | Timely | Fork-join pattern with filtering |
| identity | Timely | Pass-through operations |
| join | Timely | Join operations between streams |
| upcase | Timely | String transformations |
| reachability | Differential | Graph reachability computation |

## Understanding Results

Benchmark results include:
- **Time**: Mean execution time with confidence intervals
- **Throughput**: Operations per second (where applicable)
- **Comparison**: Performance vs. previous runs

## Troubleshooting

### Build Errors

If you encounter build errors:

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Rebuild
cargo build
```

### Missing Dependencies

Ensure you have all system dependencies:

```bash
# On Ubuntu/Debian
sudo apt-get install build-essential

# On macOS
xcode-select --install
```

## Next Steps

- Read the [README.md](README.md) for detailed information
- Check [BENCHMARK_DETAILS.md](BENCHMARK_DETAILS.md) for benchmark internals
- See [MIGRATION.md](MIGRATION.md) for migration history

## Getting Help

For issues or questions:
1. Check existing documentation
2. Review benchmark source code in `benches/benches/`
3. Consult the main Hydro repository documentation
