# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for comparing Hydro (DFIR) performance with timely-dataflow and differential-dataflow implementations.

## Purpose

This repository was created to separate benchmarks that depend on timely and differential-dataflow from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation:

1. **Reduces build dependencies** - The main repository no longer requires timely/differential-dataflow dependencies
2. **Improves build times** - Developers working on core functionality have faster builds
3. **Maintains performance comparison capability** - Performance engineers can still run comparative benchmarks
4. **Follows separation of concerns** - Core implementation is separated from benchmarking infrastructure

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                    # Benchmark implementations
│   ├── benches/               # Individual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   └── *.txt             # Test data files
│   ├── build.rs              # Build script
│   ├── Cargo.toml            # Benchmark dependencies
│   └── README.md             # Benchmark documentation
├── Cargo.toml                 # Workspace configuration
└── README.md                  # This file
```

## Dependencies

This repository depends on the main `bigweaver-agent-canary-hydro-zeta` repository for:
- `dfir_rs` - The DFIR runtime and operators
- `sinktools` - Supporting utilities

**Important**: Both repositories must be cloned in the same parent directory:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic
cargo bench --bench reachability

# Generate HTML reports (available in target/criterion/)
cargo bench
```

## Benchmark Types

The benchmarks compare three implementations across various dataflow patterns:

1. **DFIR (Hydro)** - The native Hydro implementation
2. **Timely Dataflow** - Reference timely-dataflow implementation
3. **Differential Dataflow** - Reference differential-dataflow implementation

### Available Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Multiple inputs converging to single output
- **fan_out** - Single input distributing to multiple outputs
- **fork_join** - Parallel processing with synchronization
- **identity** - Pass-through operations (baseline)
- **join** - Relational join operations
- **reachability** - Graph reachability computations
- **upcase** - String transformation operations

## Development

### Prerequisites

- Rust toolchain (see `rust-toolchain.toml` in main repository)
- Main `bigweaver-agent-canary-hydro-zeta` repository cloned

### Building

```bash
cargo build --release
```

### Testing

```bash
cargo test
```

## Migration History

These benchmarks were migrated from the main repository to maintain:
- Clean separation of core functionality and performance testing
- Reduced compilation dependencies for main repository
- Preserved ability to run cross-implementation performance comparisons

For Hydro-native benchmarks (without external dependencies), see the `benches` directory in the main `bigweaver-agent-canary-hydro-zeta` repository.

## Related Documentation

- Main repository: `bigweaver-agent-canary-hydro-zeta`
- Hydro documentation: See main repository docs
- Benchmark results: Available in `target/criterion/` after running benchmarks