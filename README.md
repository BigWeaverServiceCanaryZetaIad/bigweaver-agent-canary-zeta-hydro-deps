# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely-dataflow and differential-dataflow that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid dependency bloat in the main repository.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks for various dataflow operations using timely-dataflow, differential-dataflow, and hydroflow:

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in operation benchmarks
- **fan_out**: Fan-out operation benchmarks  
- **fork_join**: Fork-join operation benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks
- **upcase**: String uppercasing benchmarks

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Performance Comparison

These benchmarks support criterion's baseline comparison features for tracking performance changes over time. See the [Criterion documentation](https://bheisler.github.io/criterion.rs/book/user_guide/command_line_options.html#baselines) for details on using baselines.

## Migration

These benchmarks were migrated from the main hydro repository to maintain the ability to run performance comparisons while reducing the dependency footprint of the main repository. For historical context, see the benchmark migration documentation in the main repository.