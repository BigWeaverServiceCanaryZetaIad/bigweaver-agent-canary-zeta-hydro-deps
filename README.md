# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that were migrated from the `bigweaver-agent-canary-hydro-zeta` repository. The migration allows the main repository to avoid heavy compilation dependencies while maintaining the ability to run performance comparisons.

## Contents

### timely-differential-benches/

A Cargo package containing benchmarks that depend on timely-dataflow and differential-dataflow:

- **arithmetic.rs**: Basic arithmetic operations across dataflow systems
- **fan_in.rs**: Multiple input streams merging into one
- **fan_out.rs**: Single stream splitting into multiple outputs
- **fork_join.rs**: Fork and join patterns
- **identity.rs**: Identity transformation (passthrough)
- **join.rs**: Join operations between streams
- **reachability.rs**: Graph reachability computation (includes data files)
- **upcase.rs**: String transformation operations

### scripts/

Utility scripts for running and comparing benchmarks:

- **compare_benchmarks.sh**: Automated benchmark comparison tool

## Quick Start

### Running Benchmarks

To run all benchmarks in this repository:

```bash
cd timely-differential-benches
cargo bench
```

To run a specific benchmark:

```bash
cd timely-differential-benches
cargo bench --bench arithmetic
```

### Cross-Repository Comparisons

To compare benchmarks with implementations in the main repository:

1. **Clone both repositories side-by-side**:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Configure path dependencies**:
   
   Edit `timely-differential-benches/Cargo.toml` and uncomment these lines:
   ```toml
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. **Run the comparison script**:
   ```bash
   ./scripts/compare_benchmarks.sh
   ```

## Why This Repository?

The benchmarks were migrated to:

1. **Reduce dependencies**: Remove timely and differential-dataflow dependencies from the main codebase
2. **Improve build times**: Avoid compiling heavy dependencies when working on core functionality
3. **Maintain comparison capability**: Retain the ability to run performance comparisons between different dataflow implementations
4. **Simplify development**: Keep the main repository focused on core functionality

## Documentation

- **[MIGRATION.md](MIGRATION.md)**: Detailed documentation of the migration process
- **[timely-differential-benches/README.md](timely-differential-benches/README.md)**: Usage instructions for the benchmark package

## Performance Comparison

The benchmarks compare the performance of:

- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation framework
- **dfir_rs**: Dataflow Intermediate Representation implementation (when path dependencies are configured)

Results are automatically saved in the `target/criterion/` directory with HTML reports for easy visualization.

## Contributing

When adding new benchmarks:

- Add benchmarks that depend on timely/differential to this repository
- Add DFIR-only benchmarks to the main `bigweaver-agent-canary-hydro-zeta` repository

## License

Apache-2.0 (same as the main repository)