# Benchmark Guide

## Overview

This repository contains microbenchmarks comparing different dataflow implementations:
- **timely**: The timely dataflow system
- **differential-dataflow**: Differential dataflow built on timely
- **dfir_rs**: The main Hydro dataflow implementation from bigweaver-agent-canary-hydro-zeta

## Available Benchmarks

### Core Benchmarks
- **arithmetic**: Basic arithmetic operations
- **fan_in**: Multiple inputs merging into one
- **fan_out**: One input splitting to multiple outputs
- **fork_join**: Fork-join pattern
- **identity**: Pass-through operations
- **join**: Stream join operations
- **reachability**: Graph reachability computation
- **upcase**: String uppercasing

### Additional Benchmarks
- **futures**: Async futures handling
- **micro_ops**: Micro-operations
- **symmetric_hash_join**: Symmetric hash join operations
- **words_diamond**: Diamond pattern on word processing

## Running Benchmarks

### Run all benchmarks
```bash
cargo bench -p benches
```

### Run a specific benchmark
```bash
cargo bench -p benches --bench reachability
```

### Run benchmarks matching a pattern
```bash
cargo bench -p benches -- fan
```

## Understanding Results

Each benchmark typically compares multiple implementations:
- `timely/*`: Timely dataflow implementation
- `differential/*`: Differential dataflow implementation  
- `dfir_rs/*`: Hydro's DFIR implementation

Results show throughput or latency comparisons across these implementations, helping identify performance characteristics and optimization opportunities.

## Performance Comparison Workflow

To compare performance between the repositories:

1. **Ensure both repositories are up to date**
   ```bash
   # Update this repository
   cd bigweaver-agent-canary-zeta-hydro-deps
   git pull
   
   # Update the main repository (for dfir_rs changes)
   cd ../bigweaver-agent-canary-hydro-zeta
   git pull
   ```

2. **Run benchmarks**
   ```bash
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Results are saved** in `target/criterion/` directory with HTML reports

4. **For regression testing**, run benchmarks before and after changes to compare results

## Notes

- The benchmarks pull `dfir_rs` and `sinktools` from the main repository via git dependencies
- This allows comparing timely/differential-dataflow against the latest dfir_rs implementation
- Data files (e.g., `reachability_edges.txt`, `words_alpha.txt`) are included in the benches directory
