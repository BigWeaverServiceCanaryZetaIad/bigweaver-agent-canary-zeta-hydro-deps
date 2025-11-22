# Hydro Performance Comparison Benchmarks

This repository contains benchmarks that compare Hydro with timely and differential-dataflow systems. These benchmarks were separated from the main [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) repository to isolate dependencies on external dataflow systems.

## Purpose

This repository maintains performance comparison functionality while keeping the main Hydro repository free from timely and differential-dataflow dependencies. The benchmarks here allow for direct performance comparisons between:

- **Hydro** (via dfir_rs)
- **Timely Dataflow**
- **Differential Dataflow**

## Quick Start

```bash
# 1. Verify setup
make setup

# 2. Run quick benchmarks
make bench-quick

# 3. View results
make view
```

For detailed instructions, see [QUICKSTART.md](QUICKSTART.md).

## Structure

```
.
├── benches/                    # Benchmark package
│   ├── benches/               # Benchmark implementations
│   │   ├── arithmetic.rs      # Basic arithmetic operations
│   │   ├── fan_in.rs         # Fan-in pattern
│   │   ├── fan_out.rs        # Fan-out pattern
│   │   ├── fork_join.rs      # Fork-join pattern
│   │   ├── identity.rs       # Identity transformation
│   │   ├── join.rs           # Join operations
│   │   ├── reachability.rs   # Graph reachability
│   │   ├── upcase.rs         # String operations
│   │   └── *.txt             # Test data files
│   ├── Cargo.toml            # Benchmark dependencies
│   ├── build.rs              # Build script
│   └── README.md             # Benchmark documentation
├── scripts/                   # Utility scripts
│   ├── run_benchmarks.sh     # Benchmark runner with modes
│   ├── compare_results.sh    # Result comparison tool
│   ├── analyze_results.py    # Performance analysis
│   ├── setup.sh              # Setup verification
│   └── track_performance.sh  # Performance tracking over time
├── .github/workflows/         # CI/CD configuration
│   └── benchmarks.yml        # Automated benchmark runs
├── Makefile                   # Convenient command shortcuts
├── QUICKSTART.md             # Quick start guide
├── DEVELOPMENT.md            # Developer documentation
├── BENCHMARKS_COMPARISON.md  # Detailed benchmark analysis
└── README.md                 # This file
```

## Running Benchmarks

### Using Make (Recommended)

```bash
# Quick smoke test (~2-3 minutes)
make bench-quick

# All benchmarks (~10-15 minutes)
make bench-all

# Specific patterns
make bench-patterns       # fan_in, fan_out, fork_join
make bench-operations     # arithmetic, join, identity, upcase
make bench-iterative      # reachability

# Single benchmark
make bench-arithmetic
make bench-reachability
```

### Using Scripts

```bash
# Quick test
./scripts/run_benchmarks.sh -m quick

# All benchmarks
./scripts/run_benchmarks.sh -m all

# Specific benchmark
./scripts/run_benchmarks.sh -m specific -b reachability

# With baseline comparison
./scripts/run_benchmarks.sh -m all -l baseline-name

# Save as baseline
./scripts/run_benchmarks.sh -m all -s baseline-name
```

### Using Cargo Directly

```bash
# All benchmarks
cargo bench -p benches

# Specific benchmark
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
```

## Analyzing Results

### View HTML Reports

```bash
# Open in browser
make view

# Or manually
open target/criterion/report/index.html
```

### Python Analysis Tool

```bash
# Detailed analysis with comparisons
python3 scripts/analyze_results.py

# Or via make
make analyze
```

### Compare Baselines

```bash
# List available baselines
./scripts/compare_results.sh -l

# Compare two baselines
./scripts/compare_results.sh -1 baseline1 -2 baseline2

# Generate comparison report
./scripts/compare_results.sh -1 baseline1 -2 baseline2 -r
```

## Performance Tracking

Track performance over time to detect regressions:

```bash
# Record current performance
./scripts/track_performance.sh record "after-optimization"

# List all recordings
./scripts/track_performance.sh list

# Compare two recordings
./scripts/track_performance.sh compare baseline-2024-01-15 current

# Show trend for specific benchmark
./scripts/track_performance.sh trend arithmetic

# Generate full report
./scripts/track_performance.sh report
```

## Prerequisites

### Required
- **Rust**: Install from [rustup.rs](https://rustup.rs/)
- **Main Hydro Repository**: Must be at `../bigweaver-agent-canary-hydro-zeta`

### Optional
- **Python 3**: For analysis scripts
- **Make**: For convenient commands
- **bc**: For mathematical comparisons in scripts

### Verification

```bash
# Run setup verification
./scripts/setup.sh

# Or via make
make setup
```

## Benchmark Categories

### Basic Operations
- **arithmetic.rs**: Basic arithmetic operations across different systems
- **identity.rs**: Identity transformations (minimal overhead testing)
- **upcase.rs**: String manipulation operations

### Data Flow Patterns
- **fan_in.rs**: Merging multiple streams into one
- **fan_out.rs**: Splitting one stream to multiple
- **fork_join.rs**: Fork-join parallelism patterns

### Complex Operations
- **join.rs**: Various join operations between streams
- **reachability.rs**: Graph reachability algorithms (Hydro, Timely, Differential)

For detailed analysis, see [BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md).

## Development Workflow

### Testing Changes

```bash
# 1. Save current performance
make save-baseline NAME=before-change

# 2. Make changes in main repository
cd ../bigweaver-agent-canary-hydro-zeta
# ... make changes ...

# 3. Test new performance
cd ../bigweaver-agent-canary-zeta-hydro-deps
make compare-baseline NAME=before-change

# 4. Analyze results
make analyze
```

### Adding New Benchmarks

See [DEVELOPMENT.md](DEVELOPMENT.md) for detailed instructions on:
- Creating new benchmarks
- Adding test data
- Configuring Criterion
- Best practices

### CI/CD

Automated benchmarks run on:
- Push to main/develop branches
- Pull requests
- Manual workflow dispatch

Results are saved as artifacts and can be compared across runs.

## Common Tasks

### Quick Reference

```bash
# Setup and verification
make setup                    # Verify everything is configured
make info                     # Show repository information

# Running benchmarks
make bench                    # Quick test (alias for bench-quick)
make bench-all               # Full suite
make bench-patterns          # Dataflow patterns only

# Analysis
make analyze                 # Detailed analysis
make view                    # Open HTML reports
make list-baselines          # Show saved baselines

# Development
make test                    # Run tests
make clean                   # Clean everything
make clean-results           # Clean only results
```

### Regression Testing

```bash
# Start regression test workflow
make regression-test

# This will:
# 1. Save current performance as "regression-baseline"
# 2. Prompt you to make changes
# 3. Compare results: make compare-baseline NAME=regression-baseline
```

### Full Comparison Workflow

```bash
# Run complete comparison (benchmarks + analysis + view)
make full-comparison
```

## Comparison with Main Repository

| Repository | Purpose | Dependencies |
|------------|---------|--------------|
| **bigweaver-agent-canary-hydro-zeta** | Main Hydro implementation | ✓ Hydro/dfir_rs only |
| **bigweaver-agent-canary-zeta-hydro-deps** (this repo) | Performance comparisons | ✓ Hydro + Timely + Differential |

### When to Use Each

- **Main repository**: Hydro-only development and testing
- **This repository**: Performance comparisons with other systems

## Troubleshooting

### Common Issues

1. **"Cannot find dfir_rs"**
   - Ensure main repository is at `../bigweaver-agent-canary-hydro-zeta`
   - Run `make setup` to verify

2. **Benchmarks take too long**
   - Use `make bench-quick` for fast feedback
   - Or specific benchmarks: `make bench-arithmetic`

3. **Inconsistent results**
   - Close other applications
   - Disable CPU frequency scaling
   - Run multiple times and compare

For more help, see [QUICKSTART.md](QUICKSTART.md#troubleshooting).

## Documentation

- **[QUICKSTART.md](QUICKSTART.md)**: Get started in 5 minutes
- **[DEVELOPMENT.md](DEVELOPMENT.md)**: Developer guide and best practices
- **[BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md)**: Detailed benchmark analysis
- **[Makefile](Makefile)**: All available make commands

## Dependencies

### External Dependencies
- `timely-master` (0.13.0-dev.1) - Timely Dataflow
- `differential-dataflow-master` (0.13.0-dev.1) - Differential Dataflow
- `criterion` (0.5.0) - Benchmarking framework

### Internal Dependencies (from main repo)
- `dfir_rs` - Hydro's dataflow implementation
- `sinktools` - Hydro utility tools

## Contributing

When contributing:
1. Run `make setup` to verify configuration
2. Run `make test` before submitting
3. Include performance impact analysis
4. Update documentation if needed

## License

Apache-2.0 (same as main Hydro repository)