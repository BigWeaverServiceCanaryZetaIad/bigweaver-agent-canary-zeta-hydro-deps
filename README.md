# bigweaver-agent-canary-zeta-hydro-deps

This repository contains timely-dataflow and differential-dataflow benchmarks for performance comparison with the Hydro framework.

## Purpose

These benchmarks were separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Isolate external framework dependencies (timely-dataflow, differential-dataflow)
- Enable independent performance testing and comparison
- Maintain benchmark history for cross-framework evaluation

## Repository Structure

- `benches/` - Benchmark implementations comparing Hydro (DFIR) with timely and differential-dataflow

## Running Benchmarks

```bash
cd benches
cargo bench
```

See [benches/README.md](benches/README.md) for detailed documentation on available benchmarks and usage.

## Cross-Repository Performance Comparison

To compare performance with the main Hydro repository:
1. Run benchmarks in this repository to get timely/differential-dataflow baseline metrics
2. Run corresponding DFIR-native benchmarks in `bigweaver-agent-canary-hydro-zeta`
3. Compare results to evaluate relative performance characteristics