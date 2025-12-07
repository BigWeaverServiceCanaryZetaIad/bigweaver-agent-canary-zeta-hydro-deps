# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on `timely` and `differential-dataflow` libraries, 
separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) 
repository to keep the main codebase free from these dependencies.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that require timely and differential-dataflow dependencies:

- **arithmetic**: Benchmark for basic arithmetic operations
- **fan_in**: Tests fan-in (many-to-one) data flow patterns
- **fan_out**: Tests fan-out (one-to-many) data flow patterns
- **fork_join**: Tests fork-join parallel execution patterns
- **identity**: Simple identity/passthrough benchmark
- **join**: Tests various join operations
- **reachability**: Graph reachability benchmark
- **upcase**: String uppercase transformation benchmark

See [benches/README.md](benches/README.md) for detailed information on running these benchmarks.

## Why a Separate Repository?

This repository was created to:

1. **Reduce dependency bloat**: Keep the main repository free from timely/differential-dataflow dependencies
2. **Maintain performance testing**: Retain the ability to run performance benchmarks and comparisons
3. **Enable focused development**: Allow developers to work on core functionality without pulling in heavy dependencies
4. **Preserve benchmark history**: Keep the complete performance testing suite available for analysis

## Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench

# Run a specific benchmark
cargo bench --bench reachability
```

## Dependencies

This repository uses git dependencies to link to the main repository:

- `dfir_rs`: Core dataflow IR from the main repository
- `sinktools`: Utility tools from the main repository

This approach allows benchmarks to test against the latest code while keeping dependencies isolated.

## Performance Comparisons

Criterion benchmarks support baseline comparisons to track performance changes over time:

```bash
# Save current performance as baseline
cargo bench -- --save-baseline before

# Make changes, then compare
cargo bench -- --baseline before
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main repository