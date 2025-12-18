# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance benchmarks for comparing Hydro implementations with Timely and Differential-Dataflow implementations.

## Purpose

This repository serves as a companion to the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository, providing performance comparison benchmarks that depend on timely and differential-dataflow packages.

The separation allows the main repository to:
- Build faster without heavy dataflow dependencies
- Focus on core Hydro-native implementation
- Maintain a clean dependency tree

While this repository provides:
- Performance comparison benchmarks against established dataflow frameworks
- Validation that Hydro implementations match or exceed baseline performance
- Historical performance tracking across different dataflow implementations

## Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── Cargo.toml           # Benchmark package configuration with timely/differential dependencies
│   ├── build.rs             # Build script for code generation
│   ├── README.md            # Detailed benchmark documentation
│   └── benches/
│       ├── arithmetic.rs    # Arithmetic operations benchmark
│       ├── fan_in.rs        # Fan-in pattern benchmark
│       ├── fan_out.rs       # Fan-out pattern benchmark
│       ├── fork_join.rs     # Fork-join pattern benchmark
│       ├── identity.rs      # Identity transformation benchmark
│       ├── join.rs          # Join operations benchmark
│       ├── reachability.rs  # Graph reachability benchmark
│       ├── upcase.rs        # String transformation benchmark
│       └── *.txt            # Test data files
```

## Quick Start

### Prerequisites

These benchmarks require access to the Hydro source code for performance comparison. Ensure you have both repositories cloned:

```bash
# If not already cloned, get both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

Note: The benchmarks expect `dfir_rs` and `sinktools` from the main Hydro repository. If these are not available in your setup, see the Setup Requirements section in `benches/README.md`.

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fork_join
```

### Comparing with Hydro-Native Implementations

After running benchmarks here, compare with Hydro-native implementations:

```bash
cd ../bigweaver-agent-canary-hydro-zeta
cargo bench -p benches
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operations comparing different dataflow implementations |
| `fan_in` | Fan-in pattern where multiple inputs merge into one |
| `fan_out` | Fan-out pattern where one input splits to multiple outputs |
| `fork_join` | Fork-join parallel processing pattern |
| `identity` | Identity transformation (baseline performance) |
| `join` | Relational join operations |
| `reachability` | Graph reachability computation |
| `upcase` | String transformation operations |

## Dependencies

The benchmarks in this repository depend on:
- **timely-master** (v0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (v0.13.0-dev.1) - Differential dataflow framework
- **criterion** - Benchmarking harness

## Migration History

These benchmarks were migrated from the main bigweaver-agent-canary-hydro-zeta repository on December 18, 2024. For detailed migration information, see [BENCHMARK_MIGRATION.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARK_MIGRATION.md) in the main repository.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro implementation repository with Hydro-native benchmarks

## Contributing

When adding new benchmarks:
1. Ensure they compare Hydro with timely/differential-dataflow implementations
2. Follow existing benchmark structure and naming conventions
3. Update this README and the benches/README.md
4. Add appropriate test data files if needed
5. Document expected performance characteristics

## License

See LICENSE file in the root directory.