# Migration Notes

## Purpose

This repository was created to isolate timely and differential-dataflow dependencies from the main `bigweaver-agent-canary-hydro-zeta` (Hydro) repository.

## What Was Moved

### Benchmarks

The following performance comparison benchmarks were moved from `bigweaver-agent-canary-hydro-zeta/benches` to this repository:

1. **arithmetic.rs** - Arithmetic operations performance comparison
2. **fan_in.rs** - Fan-in dataflow pattern benchmarks
3. **fan_out.rs** - Fan-out dataflow pattern benchmarks
4. **fork_join.rs** - Fork-join dataflow pattern benchmarks
5. **identity.rs** - Identity operation benchmarks
6. **join.rs** - Join operation benchmarks
7. **reachability.rs** - Graph reachability algorithm benchmarks (uses differential-dataflow)
8. **upcase.rs** - String uppercase conversion benchmarks

### Supporting Files

- **build.rs** - Build script for generating fork_join benchmark code
- **reachability_edges.txt** - Test data for reachability benchmark
- **reachability_reachable.txt** - Test data for reachability benchmark

### Dependencies Isolated

The following dependencies are now only in this repository:
- `timely` (package: `timely-master`, version: `0.13.0-dev.1`)
- `differential-dataflow` (package: `differential-dataflow-master`, version: `0.13.0-dev.1`)

## What Remains in the Source Repository

The following benchmarks remain in `bigweaver-agent-canary-hydro-zeta/benches` as they don't depend on timely or differential-dataflow:

- **futures.rs**
- **micro_ops.rs**
- **symmetric_hash_join.rs**
- **words_diamond.rs**

## Updated Files in Source Repository

The following files were updated in `bigweaver-agent-canary-hydro-zeta`:

1. **benches/Cargo.toml** - Removed timely and differential-dataflow dependencies and benchmark entries
2. **benches/README.md** - Updated documentation to reference this repository
3. **benches/build.rs** - Removed (only needed for fork_join benchmark)
4. **CONTRIBUTING.md** - Updated repository structure documentation
5. **.github/workflows/benchmark.yml** - Added note about moved benchmarks

## Performance Comparison Functionality

All performance comparison functionality has been retained. The benchmarks in this repository:

- Compare Hydro/DFIR implementations against Timely Dataflow and Differential Dataflow
- Enable regression tracking
- Provide baseline comparisons with raw iterators and other implementations
- Support the same benchmark runner and reporting tools

## Running Benchmarks

See [benches/README.md](benches/README.md) for instructions on running the benchmarks.

## CI/CD Integration

A GitHub Actions workflow (`.github/workflows/benchmark.yml`) has been added to this repository to run benchmarks on a schedule and when requested, maintaining the same functionality as the original repository.
