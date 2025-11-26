# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that compare Hydro/dfir_rs performance with timely and differential-dataflow implementations.

## Purpose

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Isolate timely and differential-dataflow dependencies from the main codebase
- Maintain performance comparison capabilities
- Support separate dependency management
- Follow the team's architectural pattern of separating concerns

## Available Benchmarks

### Dataflow Pattern Benchmarks

- **`arithmetic.rs`** - Arithmetic operation benchmarks comparing timely vs hydro
- **`fan_in.rs`** - Fan-in pattern benchmarks with timely comparisons
- **`fan_out.rs`** - Fan-out pattern benchmarks with timely comparisons
- **`fork_join.rs`** - Fork-join pattern benchmarks with timely comparisons
- **`identity.rs`** - Identity operation benchmarks comparing timely vs hydro
- **`join.rs`** - Join operation benchmarks with timely comparisons
- **`reachability.rs`** - Graph reachability benchmarks comparing timely, differential, and hydro
- **`upcase.rs`** - String transformation benchmarks with timely comparisons

## Running Benchmarks

### Run All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmarks
```bash
cargo bench -p timely-differential-benches --bench arithmetic
cargo bench -p timely-differential-benches --bench fan_in
cargo bench -p timely-differential-benches --bench fan_out
cargo bench -p timely-differential-benches --bench fork_join
cargo bench -p timely-differential-benches --bench identity
cargo bench -p timely-differential-benches --bench join
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench upcase
```

### Run with Specific Patterns
```bash
# Run only timely benchmarks
cargo bench -p timely-differential-benches -- timely

# Run only hydro benchmarks
cargo bench -p timely-differential-benches -- hydro

# Run only differential-dataflow benchmarks
cargo bench -p timely-differential-benches -- differential
```

## Dependencies

This benchmark suite requires:
- **timely-master** (v0.13.0-dev.1) - For timely dataflow comparisons
- **differential-dataflow-master** (v0.13.0-dev.1) - For differential dataflow comparisons
- **dfir_rs** - The Hydro dataflow implementation (referenced from main repository)
- **criterion** - For benchmarking framework

## Data Files

- `reachability_edges.txt` - Graph edge data for reachability benchmarks (521KB)
- `reachability_reachable.txt` - Expected reachable nodes data (38KB)

These files are used by the reachability benchmark to test graph processing performance.

## Building

The `build.rs` script generates code for the fork_join benchmark. It creates a `fork_join_20.hf` file with 20 operations for testing.

## Notes

- These benchmarks provide direct performance comparisons between Hydro and timely/differential-dataflow
- Results can be used to track Hydro's performance evolution over time
- The benchmarks use Criterion for accurate statistical analysis
- HTML reports are generated in `target/criterion/` after running benchmarks

## See Also

- [RUNNING_BENCHMARKS.md](../RUNNING_BENCHMARKS.md) - Detailed instructions for running and interpreting benchmarks
- [QUICK_START.md](../QUICK_START.md) - Quick setup guide
- Main repository: [bigweaver-agent-canary-hydro-zeta](../../bigweaver-agent-canary-hydro-zeta)
