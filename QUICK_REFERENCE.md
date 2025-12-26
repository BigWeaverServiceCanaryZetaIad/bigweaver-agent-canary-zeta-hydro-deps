# Quick Reference - Timely/Differential Benchmarks

## Run Commands

### All Benchmarks
```bash
cargo bench -p benches
```

### By Implementation
```bash
cargo bench -p benches -- timely        # Timely only
cargo bench -p benches -- differential  # Differential only
cargo bench -p benches -- dfir_rs       # Hydro only
```

### By Benchmark File
```bash
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench futures
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
cargo bench -p benches --bench identity
cargo bench -p benches --bench upcase
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
```

## Benchmark Matrix

| Benchmark | Timely | Differential | Hydro | Data Files |
|-----------|:------:|:------------:|:-----:|------------|
| arithmetic | ✓ | | ✓ | - |
| fan_in | ✓ | | ✓ | - |
| fan_out | ✓ | | ✓ | - |
| fork_join | ✓ | | ✓ | (generated) |
| futures | ✓ | | ✓ | - |
| identity | ✓ | | ✓ | - |
| join | ✓ | | ✓ | - |
| micro_ops | ✓ | | ✓ | - |
| reachability | ✓ | ✓ | ✓ | edges, reachable |
| symmetric_hash_join | ✓ | ✓ | ✓ | - |
| upcase | ✓ | | ✓ | - |
| words_diamond | ✓ | | ✓ | words_alpha.txt |

## New Implementations (Dec 19, 2024)

### futures.rs
- `futures/timely/dataflow_overhead` - Timely framework overhead measurement

### micro_ops.rs
- `micro/ops/timely/identity` - Identity operation
- `micro/ops/timely/map` - Map operation
- `micro/ops/timely/flat_map` - Flat map operation
- `micro/ops/timely/filter` - Filter operation

### symmetric_hash_join.rs
- `symmetric_hash_join/timely/match_keys_diff_values` - Timely join
- `symmetric_hash_join/differential/match_keys_diff_values` - Differential join

### words_diamond.rs
- `timely_diamond` - Diamond pattern with concat

## View Results

```bash
# All results
open target/criterion/report/index.html

# Specific benchmark
open target/criterion/micro_ops/report/index.html
```

## Common Patterns

### Compare Two Implementations
```bash
cargo bench -p benches --bench micro_ops -- "dfir_rs|timely"
```

### Run Specific Test
```bash
cargo bench -p benches -- "micro/ops/timely/map"
```

### Save Baseline
```bash
cargo bench -p benches -- --save-baseline before_changes
```

### Compare to Baseline
```bash
cargo bench -p benches -- --baseline before_changes
```

## Data Files Location
- `benches/benches/words_alpha.txt` (3.7 MB) - Word list
- `benches/benches/reachability_edges.txt` (521 KB) - Graph edges
- `benches/benches/reachability_reachable.txt` (38 KB) - Expected results

## Troubleshooting

### Build Issues
```bash
cargo clean
cargo check -p benches
```

### Missing Data Files
```bash
ls -lh benches/benches/*.txt
```

### Run from Correct Directory
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## Performance Tips

1. Close other applications during benchmarking
2. Run multiple times for consistency
3. Check for statistical significance (p < 0.05)
4. Compare HTML reports for detailed analysis
5. Use longer measurement time for noisy benchmarks:
   ```bash
   cargo bench -p benches -- --measurement-time 60
   ```

## Documentation

- **README.md** - Repository overview and getting started
- **benches/README.md** - Detailed benchmark documentation
- **BENCHMARK_GUIDE.md** - Complete guide for running and comparing benchmarks
- **MIGRATION.md** - History of benchmark migration
- **CHANGES.md** - Recent changes and additions

## Related Repositories

- **Main Repo**: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- **Timely**: [TimelyDataflow/timely-dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- **Differential**: [TimelyDataflow/differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow)
