# Quick Reference Guide

## Essential Commands

### Run Benchmarks
```bash
make bench              # All benchmarks
make bench-quick        # Quick mode (development)
make bench-timely       # Timely only
make bench-differential # Differential only
```

### Testing
```bash
make test               # Run all tests
make check              # Format + lint checks
./integration-test.sh   # Integration tests
./setup-validation.sh   # Full validation
```

### Using the Runner Script
```bash
./run-benchmarks.sh --help              # Show help
./run-benchmarks.sh --workers 4         # 4 worker threads
./run-benchmarks.sh --quick             # Quick mode
./run-benchmarks.sh --save-baseline v1  # Save baseline
./run-benchmarks.sh --baseline v1       # Compare against baseline
```

### Viewing Results
```bash
make view-results       # Open HTML reports
# Or manually: open target/criterion/report/index.html
```

## File Locations

### Documentation
- `README.md` - Overview
- `INSTALLATION.md` - Setup
- `BENCHMARKING.md` - Detailed guide
- `COMPARISON.md` - Performance comparison
- `CONTRIBUTING.md` - How to contribute

### Benchmarks
- `timely-benchmarks/benches/*.rs` - Timely benchmarks
- `differential-benchmarks/benches/*.rs` - Differential benchmarks

### Configuration
- `Cargo.toml` - Dependencies
- `Makefile` - Build commands
- `.github/workflows/benchmarks.yml` - CI/CD

## Benchmark Suites

### Timely (5 suites)
1. `barrier` - Synchronization
2. `exchange` - Data partitioning
3. `dataflow_construction` - Graph building
4. `progress_tracking` - Progress mechanisms
5. `unary_operators` - Map/filter/flat_map

### Differential (5 suites)
1. `arrange` - Data arrangement
2. `join` - Join operations
3. `count` - Aggregation
4. `consolidate` - Consolidation
5. `distinct` - Deduplication

## Common Tasks

### Add New Benchmark
1. Create `benches/my_benchmark.rs`
2. Add to `Cargo.toml`: `[[bench]]`
3. Update package README
4. Test: `cargo bench --bench my_benchmark`

### Compare Versions
```bash
# Save current
./run-benchmarks.sh --save-baseline before

# Make changes...

# Compare
./run-benchmarks.sh --baseline before
```

### Multi-Worker Testing
```bash
make bench-all-workers  # Tests 1, 2, 4 workers
```

## Environment Variables

```bash
export TIMELY_WORKER_THREADS=4  # Set worker count
export RUST_LOG=debug           # Enable logging
```

## Troubleshooting

### Build Issues
```bash
cargo clean && cargo build --all
```

### Slow Benchmarks
```bash
make bench-quick  # Use quick mode
```

### Permission Errors
```bash
chmod +x *.sh
```

## Quick Links

- [Timely Docs](https://docs.rs/timely/)
- [Differential Docs](https://docs.rs/differential-dataflow/)
- [Criterion Guide](https://bheisler.github.io/criterion.rs/book/)

## Help

```bash
make help              # Show Makefile targets
./run-benchmarks.sh -h # Show runner options
```
