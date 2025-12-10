# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. These were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies.

## Repository Structure

* `benches/` contains microbenchmarks for Hydro that require timely and differential-dataflow dependencies.

## Running Benchmarks

To run all benchmarks:
```bash
cd benches
cargo bench
```

To run a specific benchmark:
```bash
cd benches
cargo bench --bench reachability
```

## Performance Comparisons

To compare performance with benchmarks in the main repository:

1. Run benchmarks from this repository
2. Run benchmarks from the main repository (futures, micro_ops, symmetric_hash_join, words_diamond)
3. Compare the criterion reports generated in `target/criterion/`

Both repositories use the same criterion framework for benchmarking, so results can be directly compared.

## Submitting Changes

When contributing changes:
1. Ensure benchmarks still compile and run
2. Follow the same commit message conventions as the main repository (Conventional Commits)
3. Run `cargo clippy` and `cargo fmt` before submitting PRs
4. Update documentation if benchmark behavior changes

For general Hydro contribution guidelines, see the main repository's [CONTRIBUTING.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/CONTRIBUTING.md).
