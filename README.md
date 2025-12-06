# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to reduce dependency bloat and improve modularity.

## Contents

### Benchmarks

The `benches` directory contains benchmarks for timely and differential-dataflow dependencies. These benchmarks were moved from the main repository to isolate the performance testing of these specific dependencies.

See [benches/README.md](benches/README.md) for more information on running these benchmarks.

## Repository Structure

This repository should be checked out alongside the main repository:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

The benchmarks use relative path dependencies to access components from the main repository for performance comparisons.

## Migration Notice

**Note:** If you previously ran benchmarks in the main `bigweaver-agent-canary-hydro-zeta` repository, those benchmarks have been reorganized:

- **Moved to this repository**: All timely and differential-dataflow benchmarks (arithmetic, fan_in, fan_out, fork_join, identity, join, upcase, reachability)
- **Remaining in main repository**: Non-timely/differential benchmarks (futures, micro_ops, symmetric_hash_join, words_diamond) - if they still exist

To run the moved benchmarks:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

## Performance Comparisons

The ability to run performance comparisons is retained through the benchmark infrastructure in this repository. The benchmarks compare:

- Timely and differential-dataflow implementations
- dfir_rs (Hydroflow) implementations
- Baseline Rust implementations (iterators, channels, etc.)

Results can be compared across versions using the Criterion.rs benchmarking framework, which stores results in `target/criterion/`.