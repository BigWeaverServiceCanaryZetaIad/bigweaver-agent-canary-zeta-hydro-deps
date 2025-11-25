# Quick Reference Guide

## Common Commands

### Building

```bash
# Check all code compiles
cargo check

# Build all benchmarks
cargo build -p timely-benchmarks

# Build with optimizations
cargo build -p timely-benchmarks --release
```

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p timely-benchmarks

# Run specific benchmark
cargo bench -p timely-benchmarks --bench arithmetic
cargo bench -p timely-benchmarks --bench reachability

# Run benchmarks matching a pattern
cargo bench -p timely-benchmarks arithmetic
```

### Individual Benchmark Commands

```bash
# Arithmetic operations
cargo bench -p timely-benchmarks --bench arithmetic

# Fan-in pattern
cargo bench -p timely-benchmarks --bench fan_in

# Fan-out pattern
cargo bench -p timely-benchmarks --bench fan_out

# Fork-join pattern
cargo bench -p timely-benchmarks --bench fork_join

# Identity transformation
cargo bench -p timely-benchmarks --bench identity

# Join operations
cargo bench -p timely-benchmarks --bench join

# String transformations
cargo bench -p timely-benchmarks --bench upcase

# Graph reachability (differential dataflow)
cargo bench -p timely-benchmarks --bench reachability
```

## Benchmark Output

Benchmark results are saved in:
```
target/criterion/
```

Open HTML reports in a browser:
```
target/criterion/report/index.html
```

## Development Workflow

### Adding a New Benchmark

1. Create benchmark file: `timely-benchmarks/benches/my_benchmark.rs`
2. Add entry to `timely-benchmarks/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Update `timely-benchmarks/README.md` with benchmark description
4. Run and verify: `cargo bench -p timely-benchmarks --bench my_benchmark`

### Updating Dependencies

Edit `timely-benchmarks/Cargo.toml`:
```toml
[dev-dependencies]
timely = { package = "timely-master", version = "x.y.z" }
differential-dataflow = { package = "differential-dataflow-master", version = "x.y.z" }
```

Then update:
```bash
cargo update -p timely-benchmarks
```

## Troubleshooting

### Compilation Errors

```bash
# Clean build artifacts
cargo clean

# Update dependencies
cargo update

# Check for errors
cargo check -p timely-benchmarks
```

### Benchmark Failures

```bash
# Run with verbose output
cargo bench -p timely-benchmarks --bench reachability -- --verbose

# Run single test from benchmark
cargo bench -p timely-benchmarks --bench reachability -- reachability/timely
```

### Missing Data Files

If reachability benchmark fails, ensure data files exist:
- `timely-benchmarks/benches/reachability_edges.txt`
- `timely-benchmarks/benches/reachability_reachable.txt`

## Performance Comparison

To compare different implementations:

```bash
# Run baseline comparison
cargo bench -p timely-benchmarks --bench arithmetic -- baseline

# Save baseline results
cargo bench -p timely-benchmarks --bench arithmetic -- --save-baseline before

# Make changes...

# Compare against baseline
cargo bench -p timely-benchmarks --bench arithmetic -- --baseline before
```

## File Locations

```
Repository Root
├── Cargo.toml                          # Workspace config
├── README.md                           # Main documentation
├── MIGRATION.md                        # Migration history
├── QUICK_REFERENCE.md                  # This file
├── VERIFICATION_CHECKLIST.md          # Testing checklist
└── timely-benchmarks/
    ├── Cargo.toml                      # Package config
    ├── README.md                       # Benchmark docs
    ├── build.rs                        # Build script
    └── benches/                        # Benchmark files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Related Documentation

- [README.md](./README.md) - Repository overview
- [MIGRATION.md](./MIGRATION.md) - Migration history and details
- [timely-benchmarks/README.md](./timely-benchmarks/README.md) - Detailed benchmark documentation
- [VERIFICATION_CHECKLIST.md](./VERIFICATION_CHECKLIST.md) - Testing procedures

## Links

- Main Repository: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow
- Criterion.rs: https://github.com/bheisler/criterion.rs
