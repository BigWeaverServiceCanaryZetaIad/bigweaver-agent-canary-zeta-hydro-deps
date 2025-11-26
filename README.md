# bigweaver-agent-canary-zeta-hydro-deps

This repository contains isolated dependencies and benchmarks for `timely` and `differential-dataflow`. These components are separated from the main hydro repository to maintain cleaner dependency boundaries and prevent dependency sprawl.

## Purpose

This repository serves to:
- Isolate `timely` and `differential-dataflow` dependencies from the main codebase
- Provide dedicated benchmarks for performance testing of these dependencies
- Maintain a clean separation of concerns for dependency management

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for timely and differential-dataflow operations:
- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Stream concatenation patterns
- **fan_out**: Stream distribution patterns  
- **fork_join**: Stream splitting and joining
- **identity**: No-op pipeline operations
- **join**: Hash join operations
- **upcase**: String transformation operations
- **reachability**: Graph reachability algorithms (timely and differential)

See [benches/README.md](benches/README.md) for detailed benchmark documentation.

## Running Benchmarks

```bash
cd benches
cargo bench
```

## Dependencies

- timely-master (v0.13.0-dev.1)
- differential-dataflow-master (v0.13.0-dev.1)
- criterion (v0.5.0) for benchmarking

## Background

These benchmarks were originally part of the bigweaver-agent-canary-hydro-zeta repository but were moved here as part of a dependency hygiene initiative to keep the main repository focused on core functionality while isolating external dataflow dependencies.