# Hydro Benchmarks - Timely & Differential-Dataflow Comparison

This repository contains performance comparison benchmarks for DFIR/Hydroflow against timely-dataflow and differential-dataflow frameworks.

## Purpose

These benchmarks were separated from the main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) to:

- **Reduce dependency footprint**: Timely and differential-dataflow dependencies (~4.4MB) are no longer required in the main repository
- **Faster CI/CD**: Main repository builds don't include heavy benchmark dependencies
- **Cleaner separation**: Core Hydro framework remains focused, benchmarks are optional
- **Independent development**: Benchmarks can be versioned and updated independently
- **Optional testing**: Clone only when performance testing is needed

## Repository Structure

```
.
├── Cargo.toml              # Workspace configuration
├── README.md               # This file
└── benches/                # Benchmark crate
    ├── Cargo.toml          # Benchmark dependencies
    ├── README.md           # Detailed benchmark documentation
    ├── build.rs            # Build script for generated code
    └── benches/            # Benchmark implementations
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_diamond.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── words_alpha.txt
```

## Quick Start

### Prerequisites

- Rust (edition 2024 or later)
- Cargo

### Clone the repository

```bash
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Run all benchmarks

```bash
cargo bench
```

### Run specific benchmarks

```bash
# Run just the arithmetic benchmarks
cargo bench --bench arithmetic

# Run just the reachability benchmarks
cargo bench --bench reachability

# Run a specific test within a benchmark
cargo bench --bench arithmetic -- arithmetic/dfir_rs
```

## Benchmarks Overview

Each benchmark typically includes multiple implementations for comparison:

1. **Baseline/Raw** - Basic Rust implementation (reference point)
2. **DFIR/Hydroflow** - Using the Hydro dataflow framework
   - Surface syntax version
   - Compiled version
3. **Timely Dataflow** - Using Timely's low-latency dataflow
4. **Differential Dataflow** - Using incremental computation (where applicable)

### Available Benchmarks

| Benchmark | Description | Frameworks |
|-----------|-------------|------------|
| arithmetic | Chain of arithmetic map operations | All |
| fan_in | Multiple inputs to single operator | All |
| fan_out | Single input to multiple operators | All |
| fork_join | Parallel fork and join patterns | All |
| futures | Async futures processing | DFIR, Timely |
| identity | Passthrough/identity transformation | All |
| join | Stream join operations | All |
| micro_ops | Micro-operation performance | All |
| reachability | Graph reachability algorithms | All |
| symmetric_hash_join | Symmetric hash join | All |
| upcase | String transformations | All |
| words_diamond | Diamond-shaped dataflow | All |

## Performance Comparison Features

✅ **Direct comparison** - Same workload across multiple frameworks  
✅ **Statistical analysis** - Using Criterion.rs for robust measurements  
✅ **HTML reports** - Visual reports in `target/criterion/report/`  
✅ **Historical tracking** - Track performance over time  
✅ **Multiple metrics** - Throughput, latency, and resource usage  

## Dependencies

The benchmark suite depends on:

### Core Frameworks
- **dfir_rs** - From main Hydro repository (via git)
- **sinktools** - From main Hydro repository (via git)
- **timely** (timely-master v0.13.0-dev.1)
- **differential-dataflow** (differential-dataflow-master v0.13.0-dev.1)

### Supporting Libraries
- **criterion** (v0.5.0) - Benchmarking framework
- **tokio** (v1.29.0) - Async runtime
- **futures** (v0.3) - Async utilities
- **rand** (v0.8.0) - Random number generation
- **rand_distr** (v0.4.3) - Random distributions

## Viewing Results

After running benchmarks, view the HTML reports:

```bash
# Open the main report page
open target/criterion/report/index.html

# Or for a specific benchmark
open target/criterion/<benchmark_name>/report/index.html
```

## CI/CD Integration

While these benchmarks are separate from the main repository, they can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run benchmarks
  run: cargo bench --no-fail-fast

- name: Upload benchmark results
  uses: actions/upload-artifact@v3
  with:
    name: benchmark-results
    path: target/criterion/
```

## Contributing

When adding new benchmarks:

1. Create a new file in `benches/benches/<name>.rs`
2. Add the benchmark entry to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Implement comparison implementations for all relevant frameworks
4. Include criterion setup and group definitions
5. Update documentation

## Related Repositories

- **Hydro Project**: https://github.com/hydro-project/hydro
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

## License

Apache-2.0

## Migration History

**Date**: 2024-11-21  
**From**: bigweaver-agent-canary-hydro-zeta repository  
**Reason**: Separate benchmark dependencies from core framework for cleaner architecture

These benchmarks retain all performance comparison functionality while allowing the main Hydro repository to remain focused and lightweight.
