# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on `timely` and `differential-dataflow` packages, which have been moved from the main Hydro repository to maintain cleaner separation of concerns and reduce dependencies in the main codebase.

## Repository Structure

### `benches/`
Contains performance benchmarks for comparing DFIR, Timely, and Differential Dataflow implementations:
- **arithmetic.rs** - Basic arithmetic operations benchmarks
- **fan_in.rs** - Fan-in pattern benchmarks
- **fan_out.rs** - Fan-out pattern benchmarks
- **fork_join.rs** - Fork/join pattern benchmarks
- **futures.rs** - Async futures benchmarks
- **identity.rs** - Identity operation benchmarks
- **join.rs** - Join operation benchmarks
- **micro_ops.rs** - Micro-operation benchmarks
- **reachability.rs** - Graph reachability benchmarks
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **upcase.rs** - String uppercase benchmarks
- **words_diamond.rs** - Diamond pattern word processing benchmarks

## Running Benchmarks

### Timely/Differential Dataflow Benchmarks

Run all benchmarks:
```bash
cargo bench --package benches
```

Run a specific benchmark:
```bash
cargo bench --package benches --bench reachability
cargo bench --package benches --bench micro_ops
```

Generate HTML reports:
```bash
cargo bench --package benches
# Reports are generated in target/criterion/
```

## Performance Comparisons

These benchmarks allow for performance comparisons between:
- **DFIR** - The Dataflow Intermediate Representation runtime
- **Timely Dataflow** - The Timely dataflow system
- **Differential Dataflow** - Differential computation built on Timely

Results are generated using Criterion and include HTML reports with detailed statistics.

## Dependencies

This repository depends on:
- `timely-master` (0.13.0-dev.1) - Timely dataflow engine
- `differential-dataflow-master` (0.13.0-dev.1) - Differential dataflow engine
- `dfir_rs` (from main repository) - DFIR runtime
- `sinktools` (from main repository) - Utility tools

The main repository dependencies are referenced via git to maintain compatibility while keeping the repositories separate.

## Migration Notice

These benchmarks were previously located in the `BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta` repository under the `benches/` directory. They have been moved here to:
1. Separate benchmark-specific code from production code
2. Reduce timely and differential-dataflow dependencies in the main repository
3. Allow independent evolution of benchmarks
4. Maintain performance comparison capabilities

For the main Hydro documentation and implementation, see: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
