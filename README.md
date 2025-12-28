# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies isolated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository to maintain cleaner dependency boundaries.

## Contents

### Benchmarks

The `benches/` directory contains performance comparison benchmarks between Hydro/DFIR and other dataflow frameworks (Timely Dataflow, Differential Dataflow). These benchmarks were moved here to avoid dependency conflicts in the main repository while still enabling performance comparisons.

See [benches/README.md](benches/README.md) for detailed information about running these benchmarks.

## Purpose

This repository serves to:

1. **Isolate Dependencies**: Keep timely and differential-dataflow dependencies separate from the main Hydro codebase
2. **Maintain Benchmark Capability**: Preserve the ability to run performance comparisons against established dataflow systems
3. **Reduce Complexity**: Keep the main repository focused on core Hydro functionality without conflicting dependencies
4. **Enable Comparison**: Provide a dedicated space for competitive benchmarking

## Running Benchmarks

```bash
cd benches
cargo bench
```

For more detailed instructions, see the [benches/README.md](benches/README.md).

## Relationship to Main Repository

This repository is a companion to the main bigweaver-agent-canary-hydro-zeta repository. The benchmarks here reference the main repository via git dependencies to ensure they test the latest Hydro/DFIR code while maintaining separate dependency trees.

## Contributing

For contribution guidelines, please refer to the main Hydro repository's CONTRIBUTING.md.