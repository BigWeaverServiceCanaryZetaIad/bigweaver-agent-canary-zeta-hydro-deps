# Quick Start Guide - Benchmark Execution

## Prerequisites

Both repositories must be cloned at the same directory level:
```
/projects/sandbox/
  ├── bigweaver-agent-canary-hydro-zeta/     (main Hydro repository)
  └── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

## Quick Commands

### Run All Benchmarks
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench <benchmark-name>
```

## Available Benchmarks

| Benchmark | Description | Command |
|-----------|-------------|---------|
| `arithmetic` | Pipeline arithmetic operations | `cargo bench -p benches --bench arithmetic` |
| `fan_in` | Fan-in dataflow patterns | `cargo bench -p benches --bench fan_in` |
| `fan_out` | Fan-out dataflow patterns | `cargo bench -p benches --bench fan_out` |
| `fork_join` | Fork-join patterns | `cargo bench -p benches --bench fork_join` |
| `futures` | Async futures processing | `cargo bench -p benches --bench futures` |
| `identity` | Identity operations | `cargo bench -p benches --bench identity` |
| `join` | Hash join operations | `cargo bench -p benches --bench join` |
| `micro_ops` | Micro-operations | `cargo bench -p benches --bench micro_ops` |
| `reachability` | Graph reachability | `cargo bench -p benches --bench reachability` |
| `symmetric_hash_join` | Symmetric hash joins | `cargo bench -p benches --bench symmetric_hash_join` |
| `upcase` | String transformations | `cargo bench -p benches --bench upcase` |
| `words_diamond` | Diamond pattern processing | `cargo bench -p benches --bench words_diamond` |

## Understanding Results

### Output Location
Benchmark results are saved in: `target/criterion/`

### HTML Reports
Detailed HTML reports with charts and statistics are generated automatically:
```
target/criterion/
  ├── <benchmark-name>/
  │   ├── report/
  │   │   └── index.html    (Open in browser for detailed view)
  │   └── ...
```

### Console Output
The terminal displays:
- Time per iteration
- Statistical analysis (mean, median, std dev)
- Performance comparisons (if previous results exist)

## Example Output

```
arithmetic/timely       time:   [15.234 ms 15.456 ms 15.678 ms]
arithmetic/dfir_rs      time:   [12.123 ms 12.234 ms 12.345 ms]
                        change: [-21.5% -20.8% -20.1%] (p = 0.00 < 0.05)
                        Performance has improved.
```

## Performance Comparison

These benchmarks compare performance across multiple implementations:

- **dfir_rs (Hydro)** - Compiled and surface syntax variants
- **timely-dataflow** - Native Timely operators
- **differential-dataflow** - Incremental computation
- **Baseline** - Raw Rust implementations

## Troubleshooting

### Missing Dependencies
```bash
# Error: Could not find dfir_rs
# Solution: Ensure main repository is at ../bigweaver-agent-canary-hydro-zeta
```

### Build Errors
```bash
# Clean and rebuild
cargo clean
cargo bench -p benches
```

### Path Issues
Verify repository structure:
```bash
ls -la /projects/sandbox/
# Should show both repositories
```

## Advanced Usage

### Baseline Comparison
Save baseline for future comparisons:
```bash
cargo bench -p benches --bench arithmetic -- --save-baseline my-baseline
```

Compare against baseline:
```bash
cargo bench -p benches --bench arithmetic -- --baseline my-baseline
```

### Specific Test Selection
Run only specific test within benchmark:
```bash
cargo bench -p benches --bench arithmetic -- "timely"
```

### Custom Criterion Configuration
Modify benchmark parameters in the `.rs` files:
- Sample size
- Measurement time
- Warm-up time

## More Information

- Full documentation: See [README.md](README.md)
- Migration details: See [BENCHMARK_MIGRATION_SUMMARY.md](BENCHMARK_MIGRATION_SUMMARY.md)
- Criterion docs: https://bheisler.github.io/criterion.rs/book/
