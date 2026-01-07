# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that have been separated from the main repository to avoid unnecessary dependencies.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks for Hydro features, including:
- Timely and differential-dataflow benchmarks
- Various dataflow patterns (fan_in, fan_out, fork_join, etc.)
- Reachability algorithms
- Join operations

## Running Benchmarks

To run the benchmarks:

```bash
cd benches
cargo bench
```

To run a specific benchmark:

```bash
cd benches
cargo bench --bench <benchmark_name>
```

Available benchmarks:
- arithmetic
- fan_in
- fan_out
- fork_join
- futures
- identity
- join
- micro_ops
- reachability
- symmetric_hash_join
- upcase
- words_diamond