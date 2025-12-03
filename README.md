# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and performance testing code that depend on the [timely](https://github.com/TimelyDataflow/timely-dataflow) and [differential-dataflow](https://github.com/TimelyDataflow/differential-dataflow) packages. These benchmarks have been moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Maintain clean dependency management in the main repository
- Reduce compilation time for the main repository
- Keep timely/differential-dataflow dependencies isolated
- Allow performance comparisons between Hydro and timely/differential implementations

## Repository Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro implementations with timely/differential-dataflow:

- **Dataflow Pattern Benchmarks:**
  - `arithmetic.rs` - Basic arithmetic operations
  - `fan_in.rs` - Multiple inputs merging to single output
  - `fan_out.rs` - Single input broadcasting to multiple outputs
  - `fork_join.rs` - Fork-join pattern
  - `identity.rs` - Simple data passthrough
  - `join.rs` - Stream join operations
  
- **Application Benchmarks:**
  - `reachability.rs` - Graph reachability computation
  - `symmetric_hash_join.rs` - Hash join implementation
  - `upcase.rs` - String transformation
  - `words_diamond.rs` - Diamond-shaped dataflow with word processing
  
- **System Benchmarks:**
  - `futures.rs` - Async futures performance
  - `micro_ops.rs` - Micro-operation benchmarks

## Running Benchmarks

### Prerequisites

This repository depends on the main bigweaver-agent-canary-hydro-zeta repository for `dfir_rs` and `sinktools` crates. These dependencies are automatically fetched from the git repository.

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmark

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
```

### View Benchmark Results

Benchmark results are saved in `target/criterion/` directory with HTML reports.

## Performance Comparison Workflow

To compare performance between the main repository and these benchmarks:

1. **Clone both repositories:**
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Run benchmarks in this repository:**
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. **Results can be found in:**
   ```
   target/criterion/*/report/index.html
   ```

## Dependencies

This repository depends on:

- **timely-master** (0.13.0-dev.1) - Low-latency dataflow system
- **differential-dataflow-master** (0.13.0-dev.1) - Incremental computation framework
- **dfir_rs** - From bigweaver-agent-canary-hydro-zeta (fetched via git)
- **sinktools** - From bigweaver-agent-canary-hydro-zeta (fetched via git)

These dependencies are kept in this separate repository to avoid adding them to the main bigweaver-agent-canary-hydro-zeta repository.

## Contributing

When contributing benchmarks:

1. Follow the existing code structure and naming conventions
2. Document what the benchmark tests
3. Ensure benchmarks can run independently
4. Add new benchmarks to both the `benches/Cargo.toml` and this README

## Migration Notes

These benchmarks were moved from bigweaver-agent-canary-hydro-zeta in December 2025 to maintain clean dependency management. The original benchmark history can be found in the main repository's git history.

For questions or issues with benchmarks, please open an issue in this repository.