# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that were migrated from the `bigweaver-agent-canary-hydro-zeta` repository.

## Purpose

This repository serves to:

1. **Isolate Heavy Dependencies**: Keep timely-dataflow and differential-dataflow dependencies separate from the main codebase
2. **Enable Performance Comparisons**: Provide benchmarks to compare different dataflow implementations
3. **Improve Build Times**: Avoid compiling heavy dependencies during regular development of the main repository
4. **Maintain Benchmark History**: Preserve benchmark code for performance tracking over time

## Contents

### timely-differential-benches/

Contains benchmarks that depend on timely-dataflow and differential-dataflow:

- **arithmetic.rs**: Arithmetic operations benchmark
- **fan_in.rs**: Fan-in pattern benchmark
- **fan_out.rs**: Fan-out pattern benchmark
- **fork_join.rs**: Fork-join pattern benchmark
- **identity.rs**: Identity/passthrough benchmark
- **join.rs**: Join operations benchmark
- **reachability.rs**: Graph reachability benchmark
- **upcase.rs**: String uppercase transformation benchmark

See [timely-differential-benches/README.md](timely-differential-benches/README.md) for detailed usage instructions.

## Quick Start

### Running Standalone Benchmarks

```bash
cd timely-differential-benches
cargo bench
```

### Cross-Repository Performance Comparison

To compare performance with implementations from the main repository:

1. **Clone both repositories side-by-side**:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Configure path dependencies** in `timely-differential-benches/Cargo.toml`:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/timely-differential-benches
   # Edit Cargo.toml and uncomment the path dependencies section
   ```

3. **Run benchmarks**:
   ```bash
   cargo bench
   ```

## Scripts

### scripts/compare_benchmarks.sh

Automated script to run and compare benchmarks across different dataflow implementations.

Usage:
```bash
./scripts/compare_benchmarks.sh
```

## Migration Documentation

For details about the migration of benchmarks from the main repository, see [MIGRATION.md](MIGRATION.md).

## Performance Comparison

The benchmarks in this repository enable comparison between:

- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **babyflow**: Custom dataflow implementation (from main repo)
- **hydroflow**: Alternative dataflow implementation (from main repo)
- **spinachflow**: Another dataflow implementation variant (from main repo)

## Requirements

- Rust 1.70 or later
- Cargo

For cross-repository benchmarking:
- Both `bigweaver-agent-canary-hydro-zeta` and `bigweaver-agent-canary-zeta-hydro-deps` cloned side-by-side

## Contributing

Please refer to the main repository's contribution guidelines when working with these benchmarks.

## License

See LICENSE file in the main repository.