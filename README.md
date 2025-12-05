# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on `timely` and `differential-dataflow` packages. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to avoid adding those dependencies to the main project.

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed.

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

```bash
cargo bench --bench reachability
cargo bench --bench micro_ops
cargo bench --bench arithmetic
# ... etc
```

## Available Benchmarks

The following benchmarks are available:

- **arithmetic**: Arithmetic operations benchmark
- **fan_in**: Fan-in pattern benchmark
- **fan_out**: Fan-out pattern benchmark
- **fork_join**: Fork-join pattern benchmark
- **futures**: Futures-based benchmark
- **identity**: Identity operation benchmark
- **join**: Join operation benchmark
- **micro_ops**: Micro-operations benchmark
- **reachability**: Graph reachability benchmark
- **symmetric_hash_join**: Symmetric hash join benchmark
- **upcase**: String uppercase benchmark
- **words_diamond**: Words diamond pattern benchmark

## Performance Comparison

To compare performance with the main Hydro repository benchmarks:

1. Clone the main repository: `git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks in both repositories
3. Compare the results from the respective `target/criterion` directories

The criterion output will generate HTML reports in `target/criterion/` for detailed performance analysis.

## More Information

For more details about these benchmarks, see [BENCHMARKS.md](BENCHMARKS.md).

For information about the Hydro project, visit the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).