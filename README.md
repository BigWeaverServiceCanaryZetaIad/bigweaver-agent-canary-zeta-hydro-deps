# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely-dataflow and differential-dataflow that were separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner separation of concerns and avoid unnecessary dependencies in the main codebase.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks using timely-dataflow and differential-dataflow:
- **arithmetic**: Arithmetic operations (map) benchmarks
- **fan_in**: Fan-in pattern benchmarks  
- **reachability**: Graph reachability benchmarks (both timely and differential)

## Running Benchmarks

```bash
cd benches
cargo bench
```

For more details, see [benches/README.md](benches/README.md).

## Purpose

These benchmarks are maintained separately to:
- Enable performance comparisons with Hydro/DFIR implementations
- Avoid adding timely/differential dependencies to the main repository
- Maintain better code organization and separation of concerns