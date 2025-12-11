# Quick Start Guide

Get started with running benchmarks in under 5 minutes.

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build the project
cargo build --release
```

## Run Your First Benchmark

```bash
# Run a single benchmark
cargo bench --bench arithmetic

# View the results
open target/criterion/arithmetic/report/index.html
```

## Run All Benchmarks

```bash
# This will take several minutes
cargo bench

# View all results
open target/criterion/report/index.html
```

## Available Benchmarks

Try these benchmarks:

```bash
cargo bench --bench arithmetic     # Arithmetic pipeline
cargo bench --bench fan_in        # Fan-in pattern
cargo bench --bench fan_out       # Fan-out pattern
cargo bench --bench fork_join     # Fork-join pattern
cargo bench --bench identity      # Identity (baseline)
cargo bench --bench join          # Join operations
cargo bench --bench reachability  # Graph reachability
cargo bench --bench upcase        # String transformation
```

## Understanding Results

After running a benchmark, check:

1. **Console output** - Quick summary of performance
2. **HTML report** - Detailed analysis and charts
3. **Comparison** - Tracks performance across runs

### Example Output

```
arithmetic/dfir         time:   [123.45 ms 125.67 ms 127.89 ms]
arithmetic/timely       time:   [145.23 ms 147.45 ms 149.67 ms]
```

Lower times are better!

## Compare with Main Repository

To compare against Hydro/DFIR native benchmarks:

```bash
# Clone main repository
cd ..
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Run DFIR-only benchmarks
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Next Steps

- Read [benches/README.md](benches/README.md) for detailed benchmark documentation
- Check [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) for advanced comparison techniques
- Explore individual benchmark source code in `benches/benches/`

## Troubleshooting

### Compilation fails?

Make sure you have:
- Rust 1.70 or later: `rustc --version`
- Git credentials configured for the main repository

### Benchmarks too slow?

- Run specific benchmarks instead of all: `cargo bench --bench arithmetic`
- Use a faster machine or reduce input sizes

### Need help?

Open an issue: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps/issues
