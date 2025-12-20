# Quick Reference Guide

## Common Commands

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability

# Run benchmarks matching pattern
cargo bench dfir              # All DFIR variants
cargo bench timely            # All timely variants
cargo bench differential      # All differential variants

# Save results as baseline
cargo bench --save-baseline my-baseline

# Compare against baseline
cargo bench --baseline my-baseline
```

### Cross-Repository Comparison

```bash
# Automated comparison with main repository
bash scripts/compare_with_main.sh

# Compare with custom main repo path
bash scripts/compare_with_main.sh --main-repo /path/to/hydro

# Run only in this repository (skip main)
bash scripts/compare_with_main.sh --no-main

# Save results as named baseline
bash scripts/compare_with_main.sh --baseline pre-optimization
```

### Verification

```bash
# Verify all benchmarks are properly configured
bash scripts/verify_benchmarks.sh
```

## Benchmark Matrix

| Benchmark | DFIR | Timely | Differential | Data Files |
|-----------|------|--------|--------------|------------|
| arithmetic | ✓ | ✓ | ✓ | - |
| fan_in | ✓ | ✓ | - | - |
| fan_out | ✓ | ✓ | - | - |
| fork_join | ✓ | ✓ | - | - |
| identity | ✓ | ✓ | - | - |
| join | ✓ | ✓ | ✓ | - |
| reachability | ✓ | - | ✓ | ✓ |
| upcase | ✓ | ✓ | - | - |

## File Locations

### Benchmarks
- All benchmark files: `benches/benches/*.rs`
- Data files: `benches/benches/*.txt`

### Configuration
- Benchmark config: `benches/Cargo.toml`
- Workspace config: `Cargo.toml`

### Documentation
- Usage guide: `BENCHMARK_USAGE.md`
- Migration info: `MIGRATION.md`
- This guide: `QUICK_REFERENCE.md`
- Benchmark README: `benches/README.md`

### Scripts
- Comparison script: `scripts/compare_with_main.sh`
- Verification script: `scripts/verify_benchmarks.sh`

### Results
- HTML reports: `target/criterion/report/index.html`
- Individual reports: `target/criterion/*/report/index.html`
- Raw data: `target/criterion/*/base/`

## Benchmark Parameters

### Arithmetic
- Operations: 20 sequential additions
- Input size: 1,000,000 integers

### Reachability
- Edges: 5,394 (from reachability_edges.txt)
- Expected results: 41,652 reachable pairs

### Join
- LHS records: 1,000
- RHS records: 1,000

### Fan-In/Fan-Out
- Stream counts: 1, 3, 5, 7, 9
- Elements per stream: 100,000

### Identity
- Pipeline depths: 1, 4, 16, 32, 64
- Total elements: 10,000

### Upcase
- Strings: 10,000

## Troubleshooting

### Dependencies won't update
```bash
rm -rf ~/.cargo/git/checkouts/hydro-*
cargo fetch
cargo update
```

### Benchmarks take too long
```bash
# Run fewer benchmarks
cargo bench --bench arithmetic --bench identity

# Reduce sample size
cargo bench -- --sample-size 50
```

### Out of memory
```bash
# Run benchmarks individually
cargo bench --bench arithmetic
cargo bench --bench identity
# Skip reachability (most memory intensive)
```

### Inconsistent results
- Close other applications
- Run multiple times
- Use baselines for comparison
- Check system load with `top` or `htop`

## Performance Tips

### Before benchmarking
1. Close unnecessary applications
2. Ensure stable power supply (laptops: plug in)
3. Disable CPU frequency scaling (Linux):
   ```bash
   sudo cpupower frequency-set -g performance
   ```

### During benchmarking
- Avoid other CPU-intensive tasks
- Let benchmarks complete without interruption
- Monitor system temperature

### After benchmarking
- Save baselines for important results
- Document system configuration
- Compare with known-good baselines

## Integration with Main Repository

### Workflow for DFIR optimization
1. Make changes in main repository
2. Commit changes
3. Update deps in this repository: `cargo update`
4. Run comparison: `bash scripts/compare_with_main.sh`
5. Analyze results in HTML reports

### CI/CD Integration
See `BENCHMARK_USAGE.md` section "CI/CD Integration" for example configurations.

## Key Dependencies

- **dfir_rs**: DFIR runtime (git dependency from hydro-project/hydro)
- **timely**: v0.13.0-dev.1 (aliased from timely-master)
- **differential-dataflow**: v0.13.0-dev.1 (aliased from differential-dataflow-master)
- **criterion**: v0.5.0 (benchmark framework)
- **sinktools**: DFIR utilities (git dependency from hydro-project/hydro)

## Related Repositories

- **Main repository**: bigweaver-agent-canary-hydro-zeta
  - DFIR-native benchmarks
  - Core Hydro implementation
  
- **Upstream**: hydro-project/hydro
  - Original Hydro project
  - DFIR source

## Getting Help

### Documentation
1. Check `BENCHMARK_USAGE.md` for detailed information
2. Review `MIGRATION.md` for context
3. Read `benches/README.md` for quick reference
4. Consult this guide for common tasks

### Issues
- DFIR implementation issues → main repository
- Benchmark infrastructure issues → this repository
- Timely/Differential questions → upstream documentation

### Resources
- [Criterion.rs Documentation](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow](https://timelydataflow.github.io/differential-dataflow/)
- [Hydro Documentation](https://hydro.run/)
