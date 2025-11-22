# Quick Start Guide

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmarks

#### Timely Benchmarks
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench upcase
```

#### Differential-Dataflow Benchmarks
```bash
cargo bench -p timely-differential-benches --bench reachability
```

## View Results

After running benchmarks, view HTML reports:
```bash
# Open in browser
firefox target/criterion/*/report/index.html

# Or list available reports
ls -la target/criterion/*/report/index.html
```

## Performance Comparison

### Compare with Baseline
```bash
# Run benchmarks and save as baseline
cargo bench -p timely-differential-benches -- --save-baseline my-baseline

# Make changes...

# Compare against baseline
cargo bench -p timely-differential-benches -- --baseline my-baseline
```

### Cross-Repository Comparison
```bash
# Run in this repository
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p timely-differential-benches

# Run in main repository
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
cargo bench -p benches

# Compare results in target/criterion/ directories
```

## Benchmark Descriptions

| Benchmark | Description | Dependency |
|-----------|-------------|------------|
| arithmetic | Basic arithmetic operations | Timely |
| fan_in | Fan-in pattern (multiple inputs to one output) | Timely |
| fan_out | Fan-out pattern (one input to multiple outputs) | Timely |
| fork_join | Fork-join parallel pattern | Timely |
| identity | Identity transformation (passthrough) | Timely |
| join | Join operations | Timely |
| upcase | String uppercase transformation | Timely |
| reachability | Graph reachability computation | Differential |

## Data Files

- `benches/benches/reachability_edges.txt` - Graph edges for reachability benchmark
- `benches/benches/reachability_reachable.txt` - Expected reachable nodes

## Common Tasks

### Test Build Without Running
```bash
cargo test -p timely-differential-benches --no-run
```

### Check Compilation
```bash
cargo check -p timely-differential-benches
```

### Build Benchmarks
```bash
cargo build -p timely-differential-benches --benches
```

### Clean Build Artifacts
```bash
cargo clean
```

## Troubleshooting

### Benchmarks Not Found
Ensure you're using the correct package name:
```bash
cargo bench -p timely-differential-benches
```

### Dependency Issues
Update dependencies:
```bash
cargo update
```

### View Dependency Tree
```bash
cargo tree -p timely-differential-benches
```

## Documentation

- [README.md](README.md) - Repository overview
- [benches/README.md](benches/README.md) - Detailed benchmark documentation
- [MIGRATION_NOTES.md](MIGRATION_NOTES.md) - Migration information
- [CHANGES_README.md](CHANGES_README.md) - Comprehensive changes

## Getting Help

For questions:
1. Check documentation files listed above
2. Review the main Hydro repository documentation
3. Refer to team communication channels
