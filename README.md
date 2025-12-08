# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require external dependencies like timely and differential-dataflow.

## Purpose

This repository was created to separate heavyweight external dependencies (like timely and differential-dataflow) from the main bigweaver-agent-canary-hydro-zeta repository while maintaining the ability to run performance comparisons and benchmarks.

## Contents

### Benchmarks

The `benches` directory contains performance benchmarks that depend on timely and differential-dataflow:
- Arithmetic operations
- Fan-in/fan-out patterns
- Fork-join patterns
- Identity operations
- Join operations
- Graph reachability
- Uppercase transformations

See [benches/README.md](benches/README.md) for details on running the benchmarks.

## Integration

This repository is designed to work alongside the main bigweaver-agent-canary-hydro-zeta repository. To run complete performance comparisons:

1. Clone both repositories
2. Run benchmarks in this repository for timely/differential comparisons
3. Run benchmarks in the main repository for Hydro-native implementations
4. Compare results across implementations

## Building and Testing

**Important**: These benchmarks require access to the main bigweaver-agent-canary-hydro-zeta repository for the dfir_rs dependency. See [SETUP.md](SETUP.md) for detailed setup instructions.

Quick start:
```bash
# Clone both repositories side-by-side
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

cd bigweaver-agent-canary-zeta-hydro-deps

# Edit benches/Cargo.toml and uncomment the dfir_rs and sinktools path dependencies

# Build all benchmarks
cargo build --release

# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability
```

## License

Apache-2.0