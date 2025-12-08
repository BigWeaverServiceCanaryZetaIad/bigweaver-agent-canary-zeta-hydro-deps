# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require timely and differential-dataflow.

## 📋 Overview

This repository was created to separate benchmarks that depend on `timely` and `differential-dataflow` from the main Hydro repository. This separation helps:
- Keep the main repository focused on core Hydro functionality
- Reduce build times for the main repository
- Maintain performance comparison capabilities with timely/differential-dataflow
- Isolate dependencies that are only needed for specific benchmarking scenarios

## 🎯 Purpose

The benchmarks in this repository allow for:
- Performance comparison between Hydro (DFIR) and timely/differential-dataflow
- Regression testing of performance characteristics
- Validation that Hydro maintains competitive performance

## 📂 Structure

```
.
├── benches/              # Benchmark suite
│   ├── benches/          # Individual benchmark implementations
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
│   └── README.md         # Benchmark-specific documentation
└── README.md             # This file
```

## 🚀 Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

## 🔧 Dependencies

This repository depends on:
- `timely-master` - Timely dataflow library
- `differential-dataflow-master` - Differential dataflow library
- `dfir_rs` - From the main Hydro repository (referenced via git)
- `sinktools` - From the main Hydro repository (referenced via git)

## 📖 Related Repositories

- Main Hydro Repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)

## 📝 Migration Notes

These benchmarks were moved from the main Hydro repository to this dedicated repository to improve the separation of concerns and reduce the dependency footprint of the main repository. The benchmarks remain fully functional and continue to provide valuable performance comparison data.

For historical context, see the commit history in the main repository regarding the benchmark migration.