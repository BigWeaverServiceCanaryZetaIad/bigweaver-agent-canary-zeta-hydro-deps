# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository.

## Purpose

This repository isolates complex dependencies (`timely` and `differential-dataflow`) used for performance benchmarking, keeping the main repository lean and reducing build times. This follows the team's architectural principle of dependency separation and clean repository boundaries.

## Contents

### Benchmarks (`/benches`)

Performance benchmarks comparing Hydroflow (dfir_rs) with Timely Dataflow and Differential Dataflow implementations.

**Quick Start:**
```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability
cargo bench --bench arithmetic

# Quick performance comparison
cargo bench --bench arithmetic --bench identity --bench join
```

See [`benches/README.md`](benches/README.md) for detailed benchmark documentation.

## Available Benchmarks

The benchmark suite includes:

- **Basic Operations**: arithmetic, identity, upcase
- **Dataflow Patterns**: fan_in, fan_out, fork_join, join, symmetric_hash_join
- **Complex Workloads**: reachability (differential-dataflow), words_diamond
- **Async Operations**: futures, micro_ops

Each benchmark compares performance across multiple implementations:
- Raw Rust (baseline)
- Timely Dataflow
- Differential Dataflow (where applicable)
- Hydroflow/dfir_rs

## Dependencies

This repository depends on:
- **timely** (timely-master v0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1)
- **dfir_rs** (via git from main repository)
- **sinktools** (via git from main repository)

## Migration Information

These benchmarks were migrated from the main repository on November 24, 2024. For detailed migration information, see [`BENCHMARK_MIGRATION.md`](BENCHMARK_MIGRATION.md).

### Benefits of Separation

✅ **Reduced Dependency Complexity**: Main repository freed from timely/differential dependencies  
✅ **Faster Main Repository Builds**: Significant compilation time reduction  
✅ **Independent Versioning**: Benchmark dependencies evolve independently  
✅ **Cleaner Architecture**: Better separation of concerns  
✅ **Maintained Functionality**: All performance comparison capabilities preserved  

## Performance Comparison

This repository enables continuous performance tracking by providing:
- Comparative benchmarks across different dataflow implementations
- Criterion.rs integration with statistical analysis
- HTML report generation
- CI/CD ready benchmark suite

## Usage

### For Performance Testing
```bash
# Clone the repository
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build benchmarks
cargo build --release

# Run benchmark suite
cargo bench

# View HTML reports
open target/criterion/report/index.html
```

### For Development
When making changes to dfir_rs or Hydroflow that may affect performance:
1. Run benchmarks before changes (baseline)
2. Make your changes in the main repository
3. Run benchmarks after changes
4. Compare results and document findings
5. Include performance analysis in your PR

## CI/CD Integration

The benchmarks are designed for CI/CD integration:

```bash
# Quick benchmark suite (for CI)
cargo bench --bench arithmetic --bench identity --bench fan_in

# Full benchmark suite (comprehensive)
cargo bench
```

## Documentation

### Quick Links
- 📚 [`QUICKSTART.md`](QUICKSTART.md) - Get started in 30 seconds
- 📊 [`benches/README.md`](benches/README.md) - Detailed benchmark documentation
- 🔄 [`BENCHMARK_MIGRATION.md`](BENCHMARK_MIGRATION.md) - Migration details and rationale
- 📝 [`FILES_MIGRATED.md`](FILES_MIGRATED.md) - Complete list of migrated files
- 🤝 [`CONTRIBUTING.md`](CONTRIBUTING.md) - Contribution guidelines
- 📋 [`CHANGES_SUMMARY.md`](CHANGES_SUMMARY.md) - Complete change log
- ✅ [`TASK_COMPLETION_SUMMARY.md`](TASK_COMPLETION_SUMMARY.md) - Task completion details

### External Links
- Main repository: [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git)

## Contributing

When adding new benchmarks:
1. Place source files in `benches/benches/`
2. Add benchmark configuration to `benches/Cargo.toml`
3. Update `benches/README.md` with benchmark description
4. Follow existing naming conventions
5. Include comparative implementations where applicable
6. Document expected behavior and performance characteristics

## Related Repositories

- **Main Repository**: `bigweaver-agent-canary-hydro-zeta` - Core Hydroflow implementation
- **This Repository**: `bigweaver-agent-canary-zeta-hydro-deps` - Benchmarks and external dependencies

## License

Apache-2.0

## Questions or Issues

For questions about:
- Benchmark functionality: See `benches/README.md`
- Migration details: See `BENCHMARK_MIGRATION.md`
- Performance concerns: Open an issue in this repository
- Main repository: See main repository documentation