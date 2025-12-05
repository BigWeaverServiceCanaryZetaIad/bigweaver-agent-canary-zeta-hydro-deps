# Quick Start Guide

## Prerequisites

Ensure both repositories are cloned side-by-side:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

### Run All Benchmarks
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

### Run Specific Benchmark
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench micro_ops
```

### Run with Filters
```bash
# Run only Hydro/DFIR benchmarks
cargo bench -p benches -- dfir

# Run only Timely benchmarks
cargo bench -p benches -- timely

# Run only Differential benchmarks
cargo bench -p benches -- differential

# Run only micro-operation benchmarks
cargo bench -p benches -- micro/ops/
```

## Available Benchmarks

| Name | Description | Timely | Differential |
|------|-------------|:------:|:------------:|
| `arithmetic` | Pipeline arithmetic operations | ✅ | - |
| `fan_in` | Fan-in dataflow patterns | ✅ | - |
| `fan_out` | Fan-out dataflow patterns | ✅ | - |
| `fork_join` | Fork-join patterns | ✅ | - |
| `identity` | Identity operation benchmarks | ✅ | - |
| `join` | Join operation benchmarks | ✅ | - |
| `upcase` | String transformation benchmarks | ✅ | - |
| `reachability` | Graph reachability algorithms | ✅ | ✅ |
| `futures` | Async/futures benchmarks | - | - |
| `micro_ops` | Micro-operation benchmarks | - | - |
| `symmetric_hash_join` | Hash join benchmarks | - | - |
| `words_diamond` | Diamond pattern with word processing | - | - |

## Performance Testing Workflow

1. **Baseline**: Run benchmarks with current code
   ```bash
   cargo bench -p benches > baseline.txt
   ```

2. **Make Changes**: Edit code in `bigweaver-agent-canary-hydro-zeta`

3. **Compare**: Run benchmarks again
   ```bash
   cargo bench -p benches > updated.txt
   ```

4. **Analyze**: Compare results using Criterion's HTML reports in `target/criterion/`

## Benchmark Output

Results are saved to:
- `target/criterion/` - HTML reports with graphs
- Console output - Summary statistics

## Troubleshooting

### Path Dependency Issues
If you see errors about missing crates, verify:
```bash
ls ../bigweaver-agent-canary-hydro-zeta/dfir_rs
ls ../bigweaver-agent-canary-hydro-zeta/sinktools
```

### Build Errors
Clean and rebuild:
```bash
cargo clean
cargo bench -p benches --no-run  # Build without running
cargo bench -p benches            # Run benchmarks
```

## More Information

- Full documentation: [README.md](README.md)
- Implementation details: [BENCHMARK_IMPLEMENTATIONS.md](BENCHMARK_IMPLEMENTATIONS.md)
- Migration details: [BENCHMARK_MIGRATION.md](BENCHMARK_MIGRATION.md)
