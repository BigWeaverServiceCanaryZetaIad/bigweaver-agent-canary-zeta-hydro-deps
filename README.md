# bigweaver-agent-canary-zeta-hydro-deps

## Overview

This repository contains benchmarks and dependencies that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository. The primary purpose is to maintain performance comparison benchmarks with Timely Dataflow and Differential Dataflow while keeping these dependencies out of the main codebase.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro (dfir_rs) with Timely and Differential Dataflow:
- **arithmetic** - Basic arithmetic operations
- **fan_in** / **fan_out** - Stream fan patterns
- **fork_join** - Fork-join patterns
- **futures** - Async operations
- **identity** - Baseline identity transformation
- **join** / **symmetric_hash_join** - Join operations
- **micro_ops** - Micro-operation performance
- **reachability** - Graph reachability algorithms
- **upcase** / **words_diamond** - String and word processing

See [benches/README.md](benches/README.md) for detailed documentation on running benchmarks.

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability

# View results
open target/criterion/report/index.html
```

## Why This Repository Exists

The main Hydro repository (`bigweaver-agent-canary-hydro-zeta`) is focused on core functionality without timely and differential-dataflow dependencies. This separate repository allows us to:

1. **Maintain Performance Comparisons**: Continue benchmarking Hydro against established frameworks
2. **Keep Main Repo Clean**: Avoid dependency bloat in the main repository
3. **Independent Testing**: Run performance tests without affecting main development
4. **Preserve Benchmarks**: Keep historical benchmark code and results available

## Relationship to Main Repository

This repository depends on the main repository for:
- `dfir_rs` - Hydro's dataflow runtime
- `sinktools` - Utility tools

These are referenced as git dependencies pointing to the main repository.

## Dependencies

Key external dependencies:
- **timely** (timely-master 0.13.0-dev.1) - Timely Dataflow framework
- **differential-dataflow** (differential-dataflow-master 0.13.0-dev.1) - Differential Dataflow
- **criterion** (0.5.0) - Benchmarking framework

## Contributing

When adding new benchmarks:
1. Add benchmark files to `benches/benches/`
2. Update `benches/Cargo.toml` with new `[[bench]]` entries
3. Follow existing patterns for comparing frameworks
4. Update documentation as needed

## License

Apache-2.0 (same as main repository)