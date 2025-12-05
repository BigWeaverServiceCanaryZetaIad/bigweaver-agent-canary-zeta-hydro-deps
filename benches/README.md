# Timely and Differential-Dataflow Benchmarks

This package contains performance benchmarks for comparing Hydro (dfir_rs) with Timely Dataflow and Differential Dataflow implementations.

## Overview

These benchmarks were migrated from the [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to maintain clean dependency separation. The benchmarks test various dataflow patterns and operations to enable performance comparisons across different implementations.

## Available Benchmarks

### Dataflow Pattern Benchmarks

1. **arithmetic** - Tests arithmetic operations in dataflow pipelines
2. **fan_in** - Tests fan-in dataflow patterns where multiple streams merge
3. **fan_out** - Tests fan-out dataflow patterns where a stream splits
4. **fork_join** - Tests fork-join patterns with parallel execution
5. **identity** - Tests identity transformations (minimal overhead baseline)
6. **join** - Tests join operations between dataflows
7. **symmetric_hash_join** - Tests symmetric hash join algorithms

### Application Benchmarks

8. **reachability** - Tests graph reachability algorithms using differential dataflow
9. **words_diamond** - Tests word processing in diamond patterns
10. **upcase** - Tests string transformation operations (uppercase)

### System Benchmarks

11. **futures** - Tests futures-based asynchronous operations
12. **micro_ops** - Tests micro-level operations for detailed performance analysis

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run a Specific Benchmark

```bash
cargo bench --bench reachability
```

### Run Benchmarks with Specific Iterations

```bash
cargo bench --bench arithmetic -- --sample-size 50
```

### Generate HTML Reports

Benchmarks are configured with `html_reports` feature, so Criterion will automatically generate HTML reports in `target/criterion/`.

```bash
cargo bench
# View reports at: target/criterion/report/index.html
```

## Benchmark Data Files

The following data files are included for testing:

- **reachability_edges.txt** (55,008 lines) - Graph edges for reachability testing
- **reachability_reachable.txt** (7,855 lines) - Expected reachability results
- **words_alpha.txt** (370,104 lines) - English dictionary for word processing benchmarks
  - Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison with Hydro

Each benchmark typically includes multiple implementations:
- **dfir_rs/compiled** - Hydro's compiled dataflow implementation
- **dfir_rs/interpreted** - Hydro's interpreted dataflow implementation
- **timely** - Timely Dataflow implementation
- **differential** - Differential Dataflow implementation (where applicable)
- **baseline** - Raw/iterator-based implementations for comparison

To compare performance between implementations, run the benchmarks and examine the generated reports:

```bash
cargo bench --bench arithmetic
# Compare results in target/criterion/arithmetic/report/index.html
```

## Comparing with Main Hydro Repository

To compare performance between this repository's benchmarks and the main Hydro repository:

1. **Checkout the main Hydro repository** at a specific commit or tag:
   ```bash
   git clone https://github.com/hydro-project/hydro
   cd hydro
   git checkout <commit-sha-or-tag>
   ```

2. **Note the commit SHA** for reproducibility.

3. **Run benchmarks in both repositories** and compare the Criterion reports:
   ```bash
   # In hydro-deps repository
   cargo bench --bench <benchmark-name>
   
   # Save the criterion results
   cp -r target/criterion /tmp/hydro-deps-results
   
   # In main hydro repository (if benchmarks exist there)
   cargo bench --bench <benchmark-name>
   
   # Compare /tmp/hydro-deps-results with target/criterion
   ```

4. **Document your findings** including:
   - Commit SHAs of both repositories
   - Benchmark names and configurations
   - Hardware specifications
   - Date of benchmarking
   - Performance differences observed

## Development

### Adding New Benchmarks

1. Create a new benchmark file in `benches/`:
   ```bash
   touch benches/<benchmark_name>.rs
   ```

2. Add the benchmark configuration to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "<benchmark_name>"
   harness = false
   ```

3. Implement your benchmark using the Criterion framework.

### Modifying Existing Benchmarks

When modifying benchmarks:
- Maintain backward compatibility with existing metrics where possible
- Document any changes that affect performance comparisons
- Consider running baseline comparisons before and after changes
- Update this README if benchmark behavior changes significantly

## Dependencies

This package depends on:
- **criterion** - Benchmarking framework with statistical analysis
- **dfir_rs** - Hydro's dataflow library (from main repository)
- **timely** (timely-master) - Timely Dataflow framework
- **differential-dataflow** (differential-dataflow-master) - Differential Dataflow library
- **sinktools** - Hydro's sink utilities (from main repository)
- Various supporting libraries (futures, tokio, rand, etc.)

## Notes

- Benchmarks use Criterion's default configuration with async_tokio support
- HTML reports are automatically generated for all benchmark runs
- The `harness = false` setting allows Criterion to control the benchmark execution
- Benchmarks run with `--release` profile optimizations by default

## Troubleshooting

### Benchmark Fails to Compile

Make sure you have the correct Rust toolchain installed:
```bash
rustup show
# Should match rust-toolchain.toml in repository root
```

### Dependencies Not Found

Ensure you're running from the repository root or benches directory:
```bash
cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Performance Varies Significantly

Benchmark results can be affected by:
- System load (close other applications)
- CPU frequency scaling (use performance governor)
- Thermal throttling (ensure good cooling)
- Background processes (minimize activity)

For reproducible results, consider using:
```bash
# Linux: Set CPU governor to performance
sudo cpupower frequency-set -g performance

# Run benchmarks
cargo bench

# Restore to powersave
sudo cpupower frequency-set -g powersave
```

## More Information

For information about the benchmark migration, see:
- [BENCHMARK_GUIDE.md](https://github.com/hydro-project/hydro/blob/main/BENCHMARK_GUIDE.md) in the main Hydro repository
- [MIGRATION_SUMMARY.md](https://github.com/hydro-project/hydro/blob/main/MIGRATION_SUMMARY.md) in the main Hydro repository

---

*Migrated from bigweaver-agent-canary-hydro-zeta on 2025-11-28 (commit b161bc10)*
