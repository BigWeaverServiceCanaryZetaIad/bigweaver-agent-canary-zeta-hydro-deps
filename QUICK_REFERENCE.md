# Quick Reference: Benchmark Organization

## What's In This Repository?

This repository contains two benchmark suites for Timely and Differential Dataflow:

### 1. Comparison Benchmarks (`benches/`)
Benchmarks that compare **all three frameworks**:
- Hydro (DFIR) implementations
- Timely Dataflow implementations
- Differential Dataflow implementations

### 2. Pure Timely/Differential Benchmarks (`timely-differential-benches/`)
Isolated benchmarks with **only Timely/Differential**:
- Baseline performance measurements
- Reference implementations
- No Hydro dependencies

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                          # Comparison benchmarks (Hydro vs Timely/Differential)
│   ├── benches/
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   └── upcase.rs
│   └── Cargo.toml
│
└── timely-differential-benches/      # Pure Timely/Differential benchmarks
    ├── benches/
    │   ├── arithmetic.rs
    │   ├── fan_in.rs
    │   ├── fan_out.rs
    │   ├── fork_join.rs
    │   ├── identity.rs
    │   ├── join.rs
    │   ├── reachability.rs
    │   └── upcase.rs
    └── Cargo.toml
```

## How to Run Benchmarks

### Comparison Benchmarks (Hydro vs Timely/Differential)
```bash
# All comparison benchmarks
cargo bench -p benches

# Specific comparison benchmark
cargo bench -p benches --bench reachability
```

### Pure Timely/Differential Benchmarks
```bash
# All pure benchmarks
cargo bench -p timely-differential-benches

# Specific pure benchmark
cargo bench -p timely-differential-benches --bench join
```

### Using the Helper Script
```bash
# Comparison benchmarks only (default)
./run_benchmarks.bash

# Pure timely/differential benchmarks only
./run_benchmarks.bash --timely-only

# All benchmarks (comparison + pure)
./run_benchmarks.bash --all

# Specific benchmark
./run_benchmarks.bash reachability
./run_benchmarks.bash --timely-only arithmetic
```

## Why This Organization?

- ✅ Comparison benchmarks include all framework implementations
- ✅ Pure benchmarks provide baseline measurements without Hydro
- ✅ Easier to build and run timely/differential benchmarks independently
- ✅ Cleaner separation enables focused performance testing
- ✅ Reduces build complexity when only testing specific frameworks
- ✅ All performance comparison functionality is retained

## Available Benchmarks

### Both Suites Include:
- **arithmetic**: Arithmetic operations pipeline
- **fan_in**: Fan-in pattern performance
- **fan_out**: Fan-out pattern performance
- **fork_join**: Fork-join pattern performance
- **identity**: Identity dataflow performance
- **join**: Join operations performance
- **reachability**: Graph reachability computation
- **upcase**: String uppercase operations

### Comparison Benchmarks Also Include:
- Hydro (DFIR) implementations
- Baseline implementations (raw iterators, pipelines)
- Side-by-side performance comparisons

## Need More Info?

- **Comparison Benchmarks**: See [benches/README.md](benches/README.md)
- **Pure Timely/Differential Benchmarks**: See [timely-differential-benches/README.md](timely-differential-benches/README.md)
- **Performance Comparison Guide**: See [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md)
- **Repository Overview**: See [README.md](README.md)

## Quick Commands

```bash
# Run all comparison benchmarks
cargo bench -p benches

# Run all pure timely/differential benchmarks
cargo bench -p timely-differential-benches

# Run everything
./run_benchmarks.bash --all

# Run specific comparison benchmark
cargo bench -p benches --bench reachability

# Run specific pure benchmark
cargo bench -p timely-differential-benches --bench join
```
