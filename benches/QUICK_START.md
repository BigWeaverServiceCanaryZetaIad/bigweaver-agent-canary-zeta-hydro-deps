# Quick Start Guide

## Prerequisites

1. Rust toolchain installed (https://rustup.rs/)
2. Both repositories cloned:
   ```
   /projects/sandbox/bigweaver-agent-canary-hydro-zeta/
   /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/
   ```

## Setup Verification

Run the setup script to verify everything is configured correctly:

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
./setup.sh
```

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

### Run Multiple Benchmarks
```bash
cargo bench --bench reachability --bench join
```

### Filter Benchmarks by Name Pattern
```bash
cargo bench reachability    # Runs reachability benchmark
cargo bench join            # Runs both join and symmetric_hash_join
```

## Benchmark List

### Basic Operations
- `arithmetic` - Arithmetic operations
- `identity` - Identity transformations
- `fan_in` - Many-to-one data flow
- `fan_out` - One-to-many data flow
- `upcase` - String transformations

### Join Operations
- `join` - Standard two-way joins
- `symmetric_hash_join` - Symmetric hash join
- `reachability` - Graph reachability with joins

### Complex Patterns
- `fork_join` - Parallel fork-join
- `futures` - Async operations
- `words_diamond` - Diamond dataflow
- `micro_ops` - Comprehensive microbenchmarks

## Understanding Results

Each benchmark compares three implementations:
1. **Hydro (dfir_rs)** - Hydro's implementation
2. **timely** - Timely-dataflow implementation
3. **differential** - Differential-dataflow implementation

Results show:
- Execution time (mean, median, std dev)
- Throughput
- Performance comparison between frameworks

## Viewing Reports

After running benchmarks, HTML reports are generated:
```bash
# Open in browser
open target/criterion/report/index.html

# Or navigate to:
# target/criterion/<benchmark_name>/report/index.html
```

## Common Options

### Save Baseline for Comparison
```bash
cargo bench -- --save-baseline my-baseline
```

### Compare Against Baseline
```bash
cargo bench -- --baseline my-baseline
```

### Quick Test (Fewer Iterations)
```bash
cargo bench -- --quick
```

### Set Sample Size
```bash
cargo bench -- --sample-size 50
```

### List Benchmarks Without Running
```bash
cargo bench -- --list
```

## Troubleshooting

### Error: Cannot find dfir_rs
**Problem**: Relative path to main Hydro repository is incorrect

**Solution**: Ensure directory structure:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Error: Compilation fails
**Problem**: Dependencies not downloaded or main repo out of date

**Solution**:
```bash
# Update main Hydro repository
cd ../../bigweaver-agent-canary-hydro-zeta
git pull
cargo build

# Then try benchmarks again
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench
```

### Slow First Run
**Problem**: First run downloads and compiles all dependencies

**Solution**: This is normal. Subsequent runs will be much faster.
```bash
# Pre-download dependencies
cargo fetch
```

## Tips

1. **Parallel Benchmarks**: Use `--test-threads` to control parallelism
   ```bash
   cargo bench -- --test-threads 1
   ```

2. **Reduce Noise**: Close other applications for more consistent results

3. **Warmup**: First run may be slower due to CPU warmup

4. **Historical Tracking**: Keep baselines to track performance over time
   ```bash
   cargo bench -- --save-baseline before-change
   # Make changes
   cargo bench -- --baseline before-change
   ```

5. **Specific Tests**: Use pattern matching for quick testing
   ```bash
   cargo bench identity  # Faster than running all
   ```

## Next Steps

- See `README.md` for detailed benchmark descriptions
- See main repository's `BENCHMARK_MIGRATION.md` for migration details
- Check Criterion documentation for advanced options: https://bheisler.github.io/criterion.rs/book/
