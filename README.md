# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require external dependencies like `timely` and `differential-dataflow`. These are maintained separately from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the core library lean and minimize build times.

## 📋 Overview

This repository serves as a dedicated location for:
- Performance benchmarks comparing Hydro with timely-dataflow and differential-dataflow
- Code that depends on external dataflow libraries
- Performance comparison tools and utilities

## 🔧 Structure

```
.
├── benches/           # Performance benchmarks
│   ├── benches/
│   │   ├── reachability.rs    # Graph reachability benchmarks
│   │   ├── micro_ops.rs       # Basic operation benchmarks
│   │   ├── fan_out.rs         # Fan-out pattern benchmarks
│   │   ├── fan_in.rs          # Fan-in pattern benchmarks
│   │   └── arithmetic.rs      # Arithmetic operation benchmarks
│   ├── Cargo.toml
│   └── README.md
└── Cargo.toml         # Workspace configuration
```

## 🎯 Purpose

By separating benchmarks that depend on `timely` and `differential-dataflow`, we:

✅ **Reduce dependency footprint** - The main Hydro repository doesn't need these heavy dependencies  
✅ **Improve build times** - Core Hydro can be built without pulling in unnecessary dependencies  
✅ **Maintain clean architecture** - Clear separation between core functionality and performance comparison tools  
✅ **Enable performance comparisons** - Dedicated environment for benchmarking against other dataflow systems  

## 🚀 Running Benchmarks

To run the benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench reachability
```

## 📚 Dependencies

The benchmarks in this repository depend on:
- `timely` (0.12) - Timely dataflow system
- `differential-dataflow` (0.12) - Differential dataflow computation
- `criterion` (0.5) - Benchmarking framework

## 🔗 Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## 💡 Migration Notes

This repository was created to separate timely and differential-dataflow benchmarks from the main Hydro repository. This migration:
- Removed `timely` and `differential-dataflow` dependencies from the core library
- Preserved all benchmark functionality in this dedicated repository
- Maintains the ability to run performance comparisons between systems
- Follows the team's architectural pattern of separating concerns into dedicated repositories

## 📝 License

Apache-2.0
