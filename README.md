# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) repository to maintain clean dependency management.

## 📋 Overview

This repository houses performance benchmarks that require timely and differential-dataflow dependencies. These benchmarks were moved here to keep the main repository's dependency footprint minimal while preserving the ability to run performance comparisons.

## 🎯 Purpose

- Maintain benchmarks requiring timely and differential-dataflow dependencies
- Enable performance comparisons between Hydro/DFIR and Timely/Differential implementations
- Keep the main repository free of heavy benchmark dependencies
- Preserve historical benchmark functionality for regression testing

## 📦 Contents

### Benchmarks (`benches/`)

The benchmarks are organized into the following categories:

#### Dataflow Patterns
- **`arithmetic.rs`** - Arithmetic operations performance
- **`fan_in.rs`** - Multiple inputs converging to single output
- **`fan_out.rs`** - Single input distributing to multiple outputs
- **`fork_join.rs`** - Parallel execution with convergence
- **`words_diamond.rs`** - Diamond-shaped dataflow pattern

#### Operations & Algorithms
- **`identity.rs`** - Pass-through operation benchmarks
- **`join.rs`** - Join operation performance
- **`symmetric_hash_join.rs`** - Symmetric hash join implementation
- **`micro_ops.rs`** - Micro-operation benchmarks
- **`upcase.rs`** - String transformation benchmarks

#### Specialized Tests
- **`reachability.rs`** - Graph reachability algorithms (with test data files)
- **`futures.rs`** - Async/futures performance

## 🚀 Getting Started

### Prerequisites

This repository requires access to the main bigweaver-agent-canary-hydro-zeta repository for dependencies:
- `dfir_rs` - Located in `../bigweaver-agent-canary-hydro-zeta/dfir_rs`
- `sinktools` - Located in `../bigweaver-agent-canary-hydro-zeta/sinktools`

Ensure both repositories are cloned in the same parent directory:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

View benchmark results:
```bash
# HTML reports are generated in target/criterion/
open target/criterion/report/index.html
```

## 🔧 Dependencies

### Core Dependencies
- **criterion** (0.5.0) - Benchmark framework with async support and HTML reports
- **timely** (timely-master 0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow** (0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - Hydro DFIR implementation (from main repo)
- **sinktools** - Output handling utilities (from main repo)

### Supporting Libraries
- **futures** (0.3) - Async runtime support
- **tokio** (1.29.0) - Async runtime with multi-thread support
- **rand** (0.8.0) - Random number generation
- **rand_distr** (0.4.3) - Random distributions
- **seq-macro** (0.2.0) - Sequence macros
- **nameof** (1.0.0) - Name reflection
- **static_assertions** (1.0.0) - Compile-time assertions

## 📊 Benchmark Data

The repository includes test data files:
- **`words_alpha.txt`** - English word list from [dwyl/english-words](https://github.com/dwyl/english-words)
- **`reachability_edges.txt`** - Graph edge data for reachability tests
- **`reachability_reachable.txt`** - Expected reachable nodes

## 🏗️ Build Configuration

The `build.rs` script generates benchmark code at build time, specifically for the fork-join pattern benchmarks.

## 💡 Performance Comparison

Each benchmark typically includes multiple implementations:
- **Hydro/DFIR** - Native Hydro implementation
- **Timely** - Timely dataflow implementation
- **Differential** - Differential dataflow implementation (where applicable)

This enables direct performance comparison between different dataflow systems.

## 🔗 Related Repositories

- [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta) - Main Hydro repository

## 📝 History

These benchmarks were originally part of the main Hydro repository and were moved here in commit `b161bc10` to separate concerns and maintain a cleaner dependency tree in the main repository.