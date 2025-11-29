# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that depend on timely and differential-dataflow packages, separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner dependency structure.

## Overview

The main repository (bigweaver-agent-canary-hydro-zeta) should not have direct dependencies on timely and differential-dataflow packages. This repository serves as a dedicated location for:

- Performance benchmarks comparing Hydro implementations with timely/differential-dataflow
- Testing and validation of compatibility with timely/differential-dataflow ecosystems
- Historical performance data and comparison tools

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark implementations
│   ├── benches/          # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   └── words_diamond.rs
│   ├── Cargo.toml        # Benchmark dependencies
│   ├── README.md         # Benchmark-specific documentation
│   └── build.rs          # Build script
└── README.md             # This file
```

## Prerequisites

Before running benchmarks, ensure you have:

1. **Rust toolchain**: Install from https://rustup.rs/
2. **Access to bigweaver-agent-canary-hydro-zeta repository**: The benchmarks depend on `dfir_rs` and `sinktools` crates from the main repository. Make sure the main repository is checked out as a sibling directory:
   ```
   /projects/sandbox/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

## Running Benchmarks

### Run All Benchmarks

To run all benchmarks in the repository:

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark:

```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Run join operations benchmark
cargo bench -p benches --bench join
```

### Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Tests arithmetic operations and computational patterns |
| `fan_in` | Tests fan-in patterns where multiple inputs converge |
| `fan_out` | Tests fan-out patterns where data is distributed to multiple outputs |
| `fork_join` | Tests fork-join parallel processing patterns |
| `futures` | Tests async/futures-based operations |
| `identity` | Tests identity operations (baseline performance) |
| `join` | Tests join operations between streams |
| `micro_ops` | Tests micro-operations and low-level primitives |
| `reachability` | Tests graph reachability algorithms |
| `symmetric_hash_join` | Tests symmetric hash join implementations |
| `upcase` | Tests string transformation operations |
| `words_diamond` | Tests diamond-pattern dataflow operations |

## Performance Comparisons

The benchmarks in this repository are designed to facilitate performance comparisons between:

1. **Hydro (dfir_rs) implementations**: Modern dataflow implementations from the main repository
2. **timely-dataflow implementations**: Reference implementations using timely/differential-dataflow
3. **Baseline comparisons**: Standard Rust implementations for context

### Interpreting Results

Benchmark results are generated using the Criterion benchmarking framework and include:
- Mean execution time
- Standard deviation
- Confidence intervals
- Comparison with previous runs (when available)

Results are saved in the `target/criterion` directory and can be viewed as HTML reports.

### Comparing Results Between Repositories

To compare performance between the main repository and this benchmark repository:

1. **Run benchmarks in both repositories** using compatible test cases
2. **Export results** from `target/criterion` for analysis
3. **Compare metrics** such as throughput, latency, and resource usage
4. **Document findings** in performance tracking issues or documentation

## Dependencies

This repository depends on:

### External Dependencies
- **timely**: Timely dataflow system (version 0.13.0-dev.1)
- **differential-dataflow**: Differential dataflow computations (version 0.13.0-dev.1)
- **criterion**: Benchmarking framework (version 0.5.0)

### Internal Dependencies (from main repository)
- **dfir_rs**: Core dataflow implementation
- **sinktools**: Utility tools for dataflow operations

## Maintenance

### Adding New Benchmarks

To add a new benchmark:

1. Create a new `.rs` file in `benches/benches/`
2. Implement the benchmark using the criterion framework
3. Add a `[[bench]]` entry in `benches/Cargo.toml`
4. Update this README with benchmark description

Example:
```rust
use criterion::{Criterion, criterion_group, criterion_main};

fn my_benchmark(c: &mut Criterion) {
    c.bench_function("my_test", |b| {
        b.iter(|| {
            // Benchmark code here
        })
    });
}

criterion_group!(benches, my_benchmark);
criterion_main!(benches);
```

### Updating Dependencies

To update timely/differential-dataflow versions:

1. Update version in `benches/Cargo.toml`
2. Run `cargo update`
3. Test all benchmarks to ensure compatibility
4. Document any API changes or performance differences

## Migration History

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency separation. The main repository should not have direct dependencies on timely and differential-dataflow packages to:

- Reduce build times for core functionality
- Minimize dependency bloat
- Separate performance testing infrastructure from production code
- Allow independent versioning of benchmark dependencies

## Contributing

When contributing benchmarks:

1. Ensure benchmarks are deterministic and reproducible
2. Include appropriate documentation and comments
3. Follow existing code style and patterns
4. Test benchmarks run successfully before submitting
5. Document any new data files or resources

## License

Apache-2.0 (same as main repository)

## Contact

For questions or issues related to benchmarks, please file an issue in the main repository with the `benchmarks` label.