# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and utilities that depend on external dataflow frameworks that are not part of the main Hydro repository.

## Purpose

This repository was created to:
1. **Isolate heavy dependencies**: Keep timely-dataflow and differential-dataflow dependencies separate from the main codebase
2. **Improve build times**: Avoid compiling these frameworks during regular Hydro development
3. **Enable performance comparisons**: Maintain the ability to benchmark Hydro against other dataflow implementations
4. **Reduce complexity**: Keep the main Hydro repository focused on core functionality

## Contents

### timely-differential-benches

Benchmarks comparing performance across different dataflow implementations:
- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation framework
- **dfir_rs**: DFIR implementation from the main Hydro repository

See [timely-differential-benches/README.md](timely-differential-benches/README.md) for detailed documentation.

## Quick Start

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. (Optional) For local development, clone the main Hydro repository side-by-side:
   ```bash
   cd ..
   git clone https://github.com/hydro-project/hydro.git bigweaver-agent-canary-hydro-zeta
   ```

3. If using local path dependencies, edit `timely-differential-benches/Cargo.toml` to use path dependencies instead of git dependencies (see configuration section below).

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark package
cargo bench -p timely-differential-benches

# Run individual benchmarks
cargo bench --bench arithmetic
cargo bench --bench reachability
```

## Configuration

### Dependency Management

The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydro repository. By default, these are pulled from the git repository, but you can configure path dependencies for faster local development.

#### Using Path Dependencies (Recommended for Development)

If both repositories are cloned side-by-side:
```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

Edit `timely-differential-benches/Cargo.toml`:
```toml
# Uncomment these lines:
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }

# Comment out these lines:
# dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
# sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

#### Using Git Dependencies (Default)

No configuration needed. Dependencies will be fetched from the remote repository automatically.

## Dependencies

### Core Dependencies
- **timely-dataflow** (timely-master): Version 0.13.0-dev.1
- **differential-dataflow** (differential-dataflow-master): Version 0.13.0-dev.1

### Hydro Dependencies
- **dfir_rs**: Dataflow IR implementation
- **sinktools**: Utility tools for Hydro

### Development Dependencies
- **criterion**: Benchmarking framework (v0.5.0)
- **tokio**: Async runtime (v1.29.0)
- **rand**: Random number generation (v0.8.0)
- And others (see individual Cargo.toml files)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                           # Workspace configuration
├── README.md                            # This file
└── timely-differential-benches/         # Benchmark package
    ├── Cargo.toml                       # Package configuration
    ├── README.md                        # Detailed benchmark documentation
    └── benches/                         # Benchmark implementations
        ├── arithmetic.rs                # Arithmetic pipeline benchmark
        ├── fan_in.rs                    # Fan-in operation benchmark
        ├── fan_out.rs                   # Fan-out operation benchmark
        ├── fork_join.rs                 # Fork-join pattern benchmark
        ├── identity.rs                  # Identity pipeline benchmark
        ├── join.rs                      # Join operation benchmark
        ├── reachability.rs              # Graph reachability benchmark
        ├── upcase.rs                    # String transformation benchmark
        ├── reachability_edges.txt       # Test data for reachability
        └── reachability_reachable.txt   # Test data for reachability
```

## Benchmark Overview

### Arithmetic (`arithmetic.rs`)
Tests pipeline arithmetic operations across different implementations. Compares:
- Raw channel-based pipeline
- Vector operations
- Timely dataflow
- DFIR implementation

### Fan Operations (`fan_in.rs`, `fan_out.rs`)
Tests merging and broadcasting patterns:
- Fan-in: Multiple inputs → Single output
- Fan-out: Single input → Multiple outputs

### Fork-Join (`fork_join.rs`)
Tests computation splitting and result merging patterns.

### Identity (`identity.rs`)
Tests pure data movement without transformation to measure framework overhead.

### Join (`join.rs`)
Tests relational join operations using timely dataflow operators.

### Reachability (`reachability.rs`)
Tests iterative graph algorithms comparing differential-dataflow and DFIR implementations.

### Upcase (`upcase.rs`)
Tests string transformation operations to measure data processing overhead.

## Results and Analysis

Benchmark results are saved to `target/criterion/` with:
- HTML reports with graphs and statistical analysis
- JSON data for programmatic analysis
- Comparison data across benchmark runs

View results by opening `target/criterion/report/index.html` in a browser.

## Contributing

When adding new benchmarks:
1. Place them in `timely-differential-benches/benches/`
2. Update `timely-differential-benches/Cargo.toml` to register the benchmark
3. Follow existing patterns for fair comparisons
4. Document the benchmark purpose and methodology

## Relationship to Main Repository

This repository is a companion to the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`). The benchmarks here were originally part of the main repository but were migrated to:
- Reduce compilation time for main repository contributors
- Isolate external framework dependencies
- Maintain long-term performance comparison capability

For more information, see the [benchmark migration notice](https://github.com/hydro-project/hydro/blob/main/benches/README.md) in the main repository.

## License

Apache-2.0

## Links

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)