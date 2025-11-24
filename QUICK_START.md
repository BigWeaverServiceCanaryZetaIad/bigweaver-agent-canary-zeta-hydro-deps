# Quick Start Guide

This guide will help you quickly get started running benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

Ensure you have Rust installed on your system. The project uses a specific Rust toolchain version that will be automatically selected by `rustup` if you have it installed.

## Clone the Repository

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

## Quick Verification

Run a single quick benchmark to verify your setup:

```bash
cargo bench -p benches --bench identity
```

This will run the identity benchmark, which is one of the simpler benchmarks and serves as a good smoke test.

## Run All Benchmarks

To run the complete benchmark suite:

```bash
cargo bench -p benches
```

**Note:** Running all benchmarks can take significant time (30+ minutes depending on your hardware).

## View Results

After running benchmarks, you can view the HTML report:

```bash
# Open in your default browser (Linux)
xdg-open target/criterion/report/index.html

# Open in your default browser (macOS)
open target/criterion/report/index.html

# Or manually navigate to target/criterion/report/index.html
```

## Common Benchmark Commands

### Run a specific benchmark
```bash
cargo bench -p benches --bench <benchmark_name>
```

Example benchmark names: `arithmetic`, `fan_in`, `fan_out`, `fork_join`, `join`, `reachability`, `upcase`

### Run benchmarks matching a pattern
```bash
cargo bench -p benches -- <pattern>
```

For example, to run all benchmarks with "fan" in their name:
```bash
cargo bench -p benches -- fan
```

### Save baseline for comparison
```bash
# Save current results as baseline
cargo bench -p benches -- --save-baseline before

# Make changes to code...

# Compare against baseline
cargo bench -p benches -- --baseline before
```

## Build Only (No Benchmark Execution)

If you want to verify that everything compiles without running benchmarks:

```bash
cargo build --release -p benches --all-targets
```

## Troubleshooting

### Issue: Compilation errors related to dfir_rs or sinktools

**Solution:** Ensure you have network access to the main repository, as these dependencies are fetched via git.

### Issue: Long compilation time

**Cause:** The timely and differential-dataflow dependencies have significant compilation overhead.

**Solution:** Use cargo's incremental compilation feature (enabled by default) and avoid `cargo clean` unless necessary.

### Issue: Out of memory during compilation

**Solution:** Reduce the number of parallel compilation jobs:
```bash
cargo bench -j 2
```

## Next Steps

- Review the [full README](README.md) for detailed information
- Check the [benches/README.md](benches/README.md) for benchmark-specific details
- Explore individual benchmark source files in `benches/benches/` to understand implementations

## Getting Help

For issues specific to:
- **Benchmark implementations**: Check the source code in `benches/benches/`
- **Dependency issues**: Refer to `benches/Cargo.toml`
- **Main repository integration**: See the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository
