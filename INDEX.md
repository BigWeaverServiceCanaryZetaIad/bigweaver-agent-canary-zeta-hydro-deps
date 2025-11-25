# Documentation Index

Quick navigation to all documentation in this repository.

## Getting Started

- **[README.md](README.md)** - Start here! Overview of the repository, benchmarks, and basic usage
- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Detailed guide for running and interpreting benchmarks

## Reference

- **[MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md)** - Details about the migration from the main repository
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes

## Quick Links

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
```

See [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for more details.

### Benchmark Descriptions

| Benchmark | Description | Type |
|-----------|-------------|------|
| arithmetic.rs | Arithmetic pipeline operations | Timely |
| fan_in.rs | Stream merging patterns | Timely |
| fan_out.rs | Stream splitting patterns | Timely |
| fork_join.rs | Parallel fork-join patterns | Timely |
| identity.rs | Minimal overhead / identity ops | Timely |
| join.rs | Stream join operations | Timely |
| reachability.rs | Graph reachability algorithms | Differential |
| upcase.rs | String transformations | Timely |

### Key Commands

```bash
# Verify setup
./verify_setup.sh

# Build benchmarks only (no run)
cargo build --benches

# Run with detailed output
cargo bench -- --verbose

# Save baseline for comparison
cargo bench -- --save-baseline my-baseline

# Compare against baseline
cargo bench -- --baseline my-baseline
```

## Documentation Structure

```
.
├── README.md              # Repository overview and quick start
├── BENCHMARK_GUIDE.md     # Comprehensive benchmarking guide
├── MIGRATION_SUMMARY.md   # Migration details and rationale
├── CHANGELOG.md           # Version history
├── INDEX.md              # This file - documentation navigation
├── Cargo.toml            # Project configuration
├── verify_setup.sh       # Verification script
└── benches/              # Benchmark files
    ├── arithmetic.rs
    ├── fan_in.rs
    ├── fan_out.rs
    ├── fork_join.rs
    ├── identity.rs
    ├── join.rs
    ├── reachability.rs
    ├── upcase.rs
    ├── reachability_edges.txt
    └── reachability_reachable.txt
```

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta/README.md)
- Main repository benchmark removal: [BENCHMARK_REMOVAL.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL.md)

## Support

For issues or questions:

1. Check [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) troubleshooting section
2. Review [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) for setup requirements
3. Run `./verify_setup.sh` to check configuration
4. Refer to main repository documentation

## Contributing

When contributing:

1. Follow existing benchmark patterns
2. Update [CHANGELOG.md](CHANGELOG.md)
3. Add documentation for new benchmarks in [README.md](README.md)
4. Run verification: `./verify_setup.sh`
5. Test benchmarks: `cargo bench`
