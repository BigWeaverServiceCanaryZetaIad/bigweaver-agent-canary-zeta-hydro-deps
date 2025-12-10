# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external frameworks like timely-dataflow and differential-dataflow.

## Purpose

This repository was created to separate benchmarks that compare Hydro's performance with other dataflow frameworks (timely and differential-dataflow) from the main Hydro repository. This separation:

- Reduces dependency footprint in the main repository
- Keeps the main repository focused on core Hydro functionality
- Maintains the ability to run performance comparisons
- Avoids transitive dependencies from external frameworks

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks for Hydro vs. timely-dataflow and differential-dataflow:
- **arithmetic**: Pipeline arithmetic operations
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **identity**: Identity transformation benchmarks
- **join**: Join operation benchmarks
- **reachability**: Graph reachability benchmarks (uses differential-dataflow)
- **upcase**: String uppercase transformation benchmarks

## Running Benchmarks

To run benchmarks comparing Hydro with other frameworks:

```bash
# Clone this repository
git clone <repository-url>
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench reachability
```

## Dependencies

The benchmarks reference the main Hydro repository as a git dependency for:
- `dfir_rs`: Core Hydro functionality
- `sinktools`: Utility tools

External dependencies:
- `timely-dataflow`: For most benchmarks
- `differential-dataflow`: For reachability benchmark

## Related Repositories

- Main Hydro repository: Contains the core Hydro implementation
- This repository: Contains comparative benchmarks with external frameworks