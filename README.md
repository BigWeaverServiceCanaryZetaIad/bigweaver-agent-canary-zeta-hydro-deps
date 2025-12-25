# bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks between Hydroflow and external dataflow systems (Timely Dataflow and Differential Dataflow).

## Contents

- **benches/** - Performance comparison benchmarks with Timely and Differential Dataflow

## Purpose

These benchmarks provide comparative analysis of Hydroflow's performance against established dataflow frameworks. They are separated from the main Hydroflow repository to:

1. Isolate external dependencies (timely-dataflow, differential-dataflow)
2. Allow independent versioning and testing
3. Maintain clean separation between core Hydroflow development and performance comparisons

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark package
cargo bench -p timely-differential-benches

# Run a specific benchmark
cargo bench -p timely-differential-benches --bench reachability
```

## More Information

See the [benches README](benches/README.md) for detailed information about individual benchmarks.