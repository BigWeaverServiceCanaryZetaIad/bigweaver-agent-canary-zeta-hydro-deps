# Quick Reference Guide

## Common Commands

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join

# Run benchmarks matching a pattern
cargo bench fan        # Runs fan_in and fan_out
cargo bench fork       # Runs fork_join

# Quick benchmark run (fewer samples)
cargo bench -- --quick

# Specific sample size
cargo bench --bench reachability -- --sample-size 10
```

### Building

```bash
# Build all benchmarks
cargo build --benches

# Build specific benchmark
cargo build --bench arithmetic

# Check without building
cargo check
```

### Testing

```bash
# Verify benchmarks compile
cargo build --benches

# Run a quick test
cargo bench --bench identity -- --quick
```

## Benchmark Summary

| Benchmark | Focus Area | Frameworks Compared |
|-----------|-----------|-------------------|
| arithmetic | Arithmetic operations | Raw, Pipeline, Timely, DFIR |
| fan_in | Fan-in pattern | Timely, DFIR |
| fan_out | Fan-out pattern | Timely, DFIR |
| fork_join | Fork-join pattern | Raw, Timely, DFIR |
| identity | Identity transformation | Raw, Timely, DFIR, Compiled DFIR |
| join | Join operations | Timely, DFIR |
| reachability | Graph reachability | Differential, Timely, DFIR |
| upcase | String operations | Raw, Iterator, Timely |

## Key Files

- `Cargo.toml` - Package configuration and dependencies
- `build.rs` - Generates code for fork_join benchmark
- `benches/*.rs` - Benchmark implementations
- `benches/reachability_*.txt` - Data files for reachability benchmark
- `README.md` - Full documentation
- `MIGRATION.md` - Migration details and dependency information

## Dependencies

### Required from Main Repo
- `dfir_rs` (path: `../bigweaver-agent-canary-hydro-zeta/dfir_rs`)
- `sinktools` (path: `../bigweaver-agent-canary-hydro-zeta/sinktools`)

### External Dependencies
- `timely` (timely-master 0.13.0-dev.1)
- `differential-dataflow` (differential-dataflow-master 0.13.0-dev.1)
- `criterion` (0.5.0) - Benchmarking framework

## Performance Tips

1. **Baseline Comparison**: Each benchmark includes raw/native implementations as performance baselines
2. **Sample Size**: Use `--sample-size` to control benchmark precision vs. time
3. **Quick Mode**: Use `--quick` for faster feedback during development
4. **Specific Tests**: Target specific benchmarks to reduce total runtime
5. **HTML Reports**: Criterion generates detailed HTML reports in `target/criterion/`

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Ensure the main Hydro repository is in the correct location:
   ```bash
   ls ../bigweaver-agent-canary-hydro-zeta/
   ```

2. Verify Rust toolchain is up to date:
   ```bash
   rustc --version
   cargo --version
   ```

3. Clean and rebuild:
   ```bash
   cargo clean
   cargo build --benches
   ```

### Missing Dependencies

If dependencies are not found:
```bash
cargo update
cargo fetch
```

### Generated Files

The `fork_join` benchmark generates `benches/fork_join_20.hf` during build. If this causes issues:
```bash
rm benches/fork_join_*.hf
cargo clean
cargo build --benches
```

## Expected Output

When running benchmarks, you should see:
- Compilation of all benchmark dependencies
- Execution of each benchmark function
- Timing statistics (mean, std dev, etc.)
- Comparison against previous runs (if available)
- HTML report generation in `target/criterion/`

## Next Steps

1. Run `cargo bench` to execute all benchmarks
2. Check `target/criterion/report/index.html` for detailed results
3. Compare performance across different frameworks
4. Update benchmarks as Hydro evolves

For more details, see `README.md` and `MIGRATION.md`.
