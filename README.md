# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that have been isolated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner separation of concerns and reduce dependency overhead.

## Contents

### Timely and Differential Dataflow Benchmarks

The `timely-benchmarks/` directory contains performance benchmarks for timely dataflow and differential-dataflow operations. These benchmarks were migrated from the main repository to isolate these dependencies.

**Key benchmarks:**
- Timely dataflow patterns: arithmetic, fan_in, fan_out, fork_join, identity, join, upcase
- Differential dataflow: reachability (graph algorithms)

See [`timely-benchmarks/README.md`](timely-benchmarks/README.md) for detailed documentation.

## Quick Start

### Running Benchmarks

```bash
# Run all timely/differential benchmarks
cargo bench -p timely-benchmarks

# Run a specific benchmark
cargo bench -p timely-benchmarks --bench reachability

# Quick test mode (fast verification)
cargo bench -p timely-benchmarks -- --test
```

### Building

```bash
# Build all benchmarks
cargo build -p timely-benchmarks

# Build with optimizations
cargo build -p timely-benchmarks --release
```

## Documentation

- **[BENCHMARK_MIGRATION_GUIDE.md](BENCHMARK_MIGRATION_GUIDE.md)** - Comprehensive guide documenting the migration of benchmarks from the main repository
- **[BUILD_VERIFICATION_CHECKLIST.md](BUILD_VERIFICATION_CHECKLIST.md)** - Detailed checklist for verifying the migration and builds
- **[timely-benchmarks/README.md](timely-benchmarks/README.md)** - Detailed benchmark documentation

## Verification

To verify that the migration was successful and all benchmarks work correctly:

```bash
./verify_benchmarks.sh
```

This script checks:
- ✅ All benchmark files are present
- ✅ Builds complete successfully
- ✅ All benchmarks pass in test mode
- ✅ Data files are accessible
- ✅ Original repository has been updated correctly

## Migration Information

**Migration Date:** November 25, 2024

**Migrated from:** `bigweaver-agent-canary-hydro-zeta/benches/`

**Rationale:**
- Maintain cleaner separation of concerns
- Isolate timely and differential-dataflow dependencies
- Reduce build times for the main repository
- Enable focused performance testing

See [BENCHMARK_MIGRATION_GUIDE.md](BENCHMARK_MIGRATION_GUIDE.md) for complete details.

## Dependencies

The benchmarks depend on:
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** (v0.5.0) - Benchmarking framework with statistical analysis

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)** - Main Hydro project repository

## Contributing

When adding new benchmarks:
1. Place them in `timely-benchmarks/benches/`
2. Update `timely-benchmarks/Cargo.toml` with the new `[[bench]]` entry
3. Update `timely-benchmarks/README.md` with benchmark description
4. Ensure benchmarks work with `cargo bench -p timely-benchmarks --bench <name> -- --test`

## License

Apache-2.0