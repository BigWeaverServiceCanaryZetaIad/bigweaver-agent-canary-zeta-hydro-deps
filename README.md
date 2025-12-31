# bigweaver-agent-canary-zeta-hydro-deps

## Purpose

This repository contains performance benchmarks comparing Hydro/dfir_rs with other established dataflow frameworks, specifically Timely Dataflow and Differential Dataflow. These benchmarks help track and verify the performance characteristics of Hydro against industry-standard implementations.

The benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to:
- Reduce unnecessary dependencies in the main codebase
- Maintain clean separation of concerns
- Isolate performance comparison code from core development

## Prerequisites

### Repository Setup

Since the benchmarks compare Hydro/dfir_rs with Timely and Differential Dataflow, they require access to the dfir_rs and sinktools crates from the main Hydro repository. You need to have both repositories checked out side-by-side:

```bash
# Clone both repositories
git clone <hydro-repo-url> bigweaver-agent-canary-hydro-zeta
git clone <deps-repo-url> bigweaver-agent-canary-zeta-hydro-deps

# Your directory structure should look like:
# parent-directory/
#   ├── bigweaver-agent-canary-hydro-zeta/
#   │   ├── dfir_rs/
#   │   ├── sinktools/
#   │   └── ...
#   └── bigweaver-agent-canary-zeta-hydro-deps/
#       └── benches/
```

The benches Cargo.toml references `../dfir_rs` and `../sinktools` which will resolve correctly when the repositories are checked out side-by-side.

### Rust Toolchain

Ensure you have Rust installed with the appropriate toolchain. The benchmarks use Criterion for statistical analysis.

## Repository Structure

- `benches/` - Benchmark suite root directory
  - `Cargo.toml` - Dependencies including timely-master (0.13.0-dev.1) and differential-dataflow-master (0.13.0-dev.1)
  - `benches/` - Individual benchmark implementations
    - `fan_in.rs` - Fan-in operations comparing dfir_rs with timely
    - `fan_out.rs` - Fan-out operations benchmarks
    - `join.rs` - Join operations comparing dfir_rs with timely
    - `reachability.rs` - Graph reachability using differential-dataflow
    - `symmetric_hash_join.rs` - Symmetric hash join benchmarks
    - `fork_join.rs` - Fork-join pattern benchmarks
    - `micro_ops.rs` - Micro-operations (map, flat_map, union, tee, fold, sort, etc.)
    - `arithmetic.rs` - Arithmetic operations benchmarks
    - `identity.rs` - Identity operation benchmarks
    - `upcase.rs` - String uppercase transformation benchmarks
    - `words_diamond.rs` - Word processing diamond pattern benchmarks
    - `futures.rs` - Async futures benchmarks
    - Supporting data files (reachability_edges.txt, reachability_reachable.txt, words_alpha.txt)

## How to Run the Benchmarks

### Run All Benchmarks

From the repository root:

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

To run a specific benchmark, use:

```bash
cargo bench -p benches --bench <benchmark_name>
```

Examples:
```bash
# Run reachability benchmark
cargo bench -p benches --bench reachability

# Run join operations benchmark
cargo bench -p benches --bench join

# Run fan-in benchmark
cargo bench -p benches --bench fan_in

# Run micro-operations benchmark
cargo bench -p benches --bench micro_ops
```

### Benchmark Results

Criterion generates detailed HTML reports in `target/criterion/` directory with:
- Statistical analysis of performance
- Comparison with previous runs
- Visual charts and graphs

## Reference

For context on the Hydro/dfir_rs framework and its architecture, please refer to the original repository:
- **Main Repository**: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
- **Documentation**: Available in the main repository's docs directory

## Notes

- The benchmarks use development versions of timely and differential-dataflow for fair comparison with the latest Hydro features
- Wordlist data is sourced from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- This repository must be checked out alongside the main Hydro repository for the path dependencies to resolve correctly