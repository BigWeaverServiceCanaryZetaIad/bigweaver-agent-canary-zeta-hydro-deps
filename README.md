# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external dataflow libraries
(timely-dataflow and differential-dataflow). These have been separated from the main
Hydro repository to keep the main codebase free of these dependencies.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for timely-dataflow and differential-dataflow that serve as
reference implementations for comparing against Hydro's performance. These include:

- Arithmetic operations
- Fan-in/fan-out patterns
- Fork-join patterns
- Stream joins
- Graph reachability (differential-dataflow)
- Identity and transformation operations

See the [benches/README.md](benches/README.md) for more details on running and comparing
benchmarks.

## Purpose

This repository enables:

1. **Dependency Isolation**: Keeps timely and differential-dataflow dependencies out of
   the main Hydro repository
2. **Performance Baselines**: Provides reference implementations for performance
   comparison
3. **Cross-Repository Benchmarking**: Allows fair performance comparisons between Hydro
   and established streaming frameworks

## Usage

### Running Benchmarks

```bash
cd benches
cargo bench
```

### Comparing with Hydro

See [benches/README.md](benches/README.md) for instructions on running cross-repository
performance comparisons.

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main Hydro project repository