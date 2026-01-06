# BigWeaver Hydro Dependencies Benchmarks

This repository contains benchmarks that depend on external dataflow dependencies (timely and differential-dataflow).

## Contents

### Benchmarks
The `/benches` directory contains microbenchmarks that use:
- **Timely Dataflow**: For testing various dataflow patterns (fan-in, fan-out, joins, etc.)
- **Differential Dataflow**: For incremental computation benchmarks (reachability)

These benchmarks were separated from the main Hydro repository to maintain a cleaner dependency structure.

## Usage

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

For more details, see the [benches README](benches/README.md).