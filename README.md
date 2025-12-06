# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for Hydro that depend on external dataflow libraries (timely and differential-dataflow). These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. Reduce build complexity in the main repository
2. Avoid including timely and differential-dataflow dependencies where not needed
3. Improve compilation times for core development
4. Maintain clean separation of concerns

## Prerequisites

These benchmarks require access to the main repository for dfir_rs and sinktools dependencies. Clone both repositories side-by-side:

```bash
# Clone both repositories into the same parent directory
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Directory structure should be:
#   parent_dir/
#     bigweaver-agent-canary-hydro-zeta/
#     bigweaver-agent-canary-zeta-hydro-deps/
```

## Benchmarks

This repository contains the following benchmarks:

- **arithmetic** - Arithmetic operations using timely dataflow
- **fan_in** - Fan-in pattern using timely concatenation operators
- **fan_out** - Fan-out pattern using timely map operators
- **fork_join** - Fork-join pattern with filtering using timely
- **identity** - Identity operations using timely dataflow
- **upcase** - Uppercase transformation using timely operators
- **join** - Join operations using timely's low-level operator API
- **reachability** - Graph reachability using differential-dataflow

## Running Benchmarks

Run all benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

Run a specific benchmark:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
# etc.
```

## Performance Comparisons

To compare performance between different versions or changes:

1. Save a baseline:
   ```bash
   cargo bench -- --save-baseline before
   ```

2. Make your changes (e.g., update dependencies, modify code)

3. Compare against the baseline:
   ```bash
   cargo bench -- --baseline before
   ```

Criterion will show you the performance differences between the baseline and current state.

## Cross-Repository Performance Testing

If you're making changes in the main repository and want to test performance impact:

1. Make your changes in `bigweaver-agent-canary-hydro-zeta`
2. Run benchmarks in this repository - they will automatically use the updated code via path dependencies
3. The benchmarks will pick up your local changes without needing to publish

Example workflow:
```bash
# Make changes in the main repo
cd bigweaver-agent-canary-hydro-zeta
# ... edit dfir_rs code ...

# Test performance impact
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench -- --save-baseline before
# ... make more changes in main repo ...
cargo bench -- --baseline before
```

## Dependencies

- **timely** (timely-master) - A low-latency data-parallel dataflow system
- **differential-dataflow** (differential-dataflow-master) - An implementation of differential dataflow over timely dataflow
- **criterion** - Statistical benchmarking framework
- **dfir_rs** - Referenced from main repository via path dependency
- **sinktools** - Referenced from main repository via path dependency

## Contributing

When adding new benchmarks that depend on timely or differential-dataflow, add them to this repository rather than the main repository.

For benchmarks that do NOT depend on these external dataflow libraries, add them to the `benches` package in the main repository.

## Links

- [Main Repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Migration Documentation](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/BENCHMARKS_MIGRATION.md)