# Hydro Dependencies Repository

This repository contains components from the Hydro project that have heavy external dependencies, separated to keep the main Hydro repository lightweight.

## Contents

### Benchmarks (`benches/`)

Benchmarks comparing Hydro performance with Timely and Differential Dataflow frameworks. These benchmarks include implementations in all three frameworks for direct comparison.

See [benches/README.md](benches/README.md) for more information on running and understanding these comparison benchmarks.

### Pure Timely/Differential Benchmarks (`timely-differential-benches/`)

Pure implementations using only Timely and Differential Dataflow frameworks (without Hydro). These serve as baseline performance measurements and reference implementations.

See [timely-differential-benches/README.md](timely-differential-benches/README.md) for details on these isolated benchmarks.

## Purpose

This repository was created to:
- **Reduce dependency bloat** in the main Hydro repository
- **Separate concerns** by isolating performance comparison code
- **Maintain functionality** while keeping the core Hydro codebase clean
- **Enable performance comparisons** without adding heavy dependencies to the main project
- **Provide baseline measurements** through isolated timely/differential benchmarks

## Related Repository

Main Hydro repository: [hydro-project/hydro](https://github.com/hydro-project/hydro)

## Running Benchmarks

### Quick Start

```bash
# Run all comparison benchmarks (Hydro vs Timely/Differential)
cargo bench -p benches

# Run pure Timely/Differential benchmarks only
cargo bench -p timely-differential-benches

# Run everything
./run_benchmarks.bash --all
```

### Using the Helper Script

```bash
# Run all comparison benchmarks
./run_benchmarks.bash

# Run only pure timely/differential benchmarks
./run_benchmarks.bash --timely-only

# Run all benchmarks (comparison + pure)
./run_benchmarks.bash --all

# Run specific comparison benchmark
./run_benchmarks.bash reachability

# Run specific pure timely/differential benchmark
./run_benchmarks.bash --timely-only join
```

For more detailed instructions, see:
- [benches/README.md](benches/README.md) - Comparison benchmarks
- [timely-differential-benches/README.md](timely-differential-benches/README.md) - Pure timely/differential benchmarks
- [PERFORMANCE_COMPARISON.md](PERFORMANCE_COMPARISON.md) - Performance analysis guide