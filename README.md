# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on `timely` and `differential-dataflow` packages. These have been separated from the main repository to maintain clean dependency management and reduce compilation time for the core Hydro development.

## 📋 Overview

This repository contains two main components:

### 1. **Microbenchmarks** (`benches/`)
Performance benchmarks comparing Hydro's dataflow operations against other frameworks:
- **Dataflow patterns**: fan-in, fan-out, fork-join, join operations
- **Stream operations**: arithmetic, identity, upcase, micro operations
- **Graph algorithms**: reachability, symmetric hash join
- **Advanced patterns**: words diamond, futures-based operations

### 2. **Distributed Protocol Benchmarks** (`hydro_test_benchmarks/`)
Benchmarks for distributed consensus protocols:
- **Paxos**: Standard and compartmentalized variants
- **Two-Phase Commit (2PC)**: Transaction coordination benchmarks
- Supporting infrastructure for key-value replicas and client-server interactions

## 🎯 Purpose

These benchmarks were moved to this dedicated repository to:
- ✅ Remove direct dependencies on `timely` and `differential-dataflow` from the main Hydro repository
- ✅ Isolate heavy dependencies to improve build times for core development
- ✅ Maintain the ability to run performance comparisons
- ✅ Preserve all benchmark functionality while keeping the main repository lean

## 🔧 Running Benchmarks

### Prerequisites

1. Rust toolchain (install from [rustup.rs](https://rustup.rs/))
2. Git access to the main Hydro repository

### Microbenchmarks

Run all microbenchmarks:
```bash
cargo bench -p benches
```

Run specific benchmark suites:
```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Run join operations benchmark
cargo bench -p benches --bench join
```

Available benchmark suites:
- `arithmetic` - Arithmetic operations on streams
- `fan_in` - Fan-in dataflow patterns
- `fan_out` - Fan-out dataflow patterns
- `fork_join` - Fork-join parallelism patterns
- `futures` - Futures-based async operations
- `identity` - Identity (passthrough) operations
- `join` - Join operations
- `micro_ops` - Micro-operation benchmarks
- `reachability` - Graph reachability algorithms
- `symmetric_hash_join` - Symmetric hash join operations
- `upcase` - String manipulation operations
- `words_diamond` - Word processing diamond pattern

### Distributed Protocol Benchmarks

Run the protocol benchmark examples:
```bash
# Paxos benchmark
cargo run --example paxos --package hydro_test_benchmarks

# Compartmentalized Paxos benchmark
cargo run --example compartmentalized_paxos --package hydro_test_benchmarks

# Two-Phase Commit benchmark
cargo run --example two_pc --package hydro_test_benchmarks
```

## 📊 Performance Comparisons

The benchmarks compare Hydro's performance against:
- **Timely Dataflow**: Low-level dataflow framework
- **Differential Dataflow**: Incremental computation framework
- **Raw implementations**: Baseline performance using standard library operations

Results are generated in HTML format (for Criterion benchmarks) and can be found in:
```
target/criterion/
```

## 🏗️ Repository Structure

```
.
├── benches/                      # Microbenchmarks package
│   ├── benches/                  # Individual benchmark files
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
│   ├── Cargo.toml
│   ├── README.md
│   └── build.rs
├── hydro_test_benchmarks/        # Distributed protocol benchmarks
│   ├── src/
│   │   ├── lib.rs
│   │   ├── compartmentalized_paxos.rs
│   │   ├── kv_replica.rs
│   │   ├── paxos.rs
│   │   ├── paxos_bench.rs
│   │   ├── paxos_with_client.rs
│   │   ├── two_pc.rs
│   │   └── two_pc_bench.rs
│   ├── examples/
│   │   ├── compartmentalized_paxos.rs
│   │   ├── paxos.rs
│   │   └── two_pc.rs
│   ├── Cargo.toml
│   └── build.rs
├── Cargo.toml                    # Workspace configuration
└── README.md                     # This file
```

## 🔗 Dependencies

This repository depends on:
- **Main Hydro Repository**: References `dfir_rs`, `hydro_lang`, `hydro_std`, `sinktools`, and other core libraries via git dependencies
- **Timely Dataflow**: `timely-master` package (isolated in this repository)
- **Differential Dataflow**: `differential-dataflow-master` package (isolated in this repository)
- **Criterion**: Benchmarking framework for microbenchmarks

## 💡 Development Notes

### Updating Dependencies

To update the reference to the main Hydro repository:
1. The git dependencies in `Cargo.toml` files point to the main repository
2. Use specific branch or tag if needed:
   ```toml
   dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", branch = "main" }
   ```

### Adding New Benchmarks

#### Microbenchmarks:
1. Add new benchmark file in `benches/benches/`
2. Register it in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_new_bench"
   harness = false
   ```

#### Protocol Benchmarks:
1. Add implementation module in `hydro_test_benchmarks/src/`
2. Add example in `hydro_test_benchmarks/examples/`
3. Register module in `src/lib.rs`
4. Register example in `Cargo.toml`

## 📚 Related Documentation

- [Main Hydro Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Hydro Documentation](https://hydro-project.github.io/hydro/)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)

## 🤝 Contributing

When contributing benchmarks:
1. Ensure benchmarks compile and run successfully
2. Include documentation explaining what the benchmark measures
3. Compare against relevant baseline implementations
4. Update this README if adding new benchmark categories

## 📝 License

Apache-2.0 (same as the main Hydro repository)