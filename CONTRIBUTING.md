# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely-dataflow and differential-dataflow. It complements the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Repository Structure

* `benches/` - Performance benchmarks using timely and differential-dataflow
  - Includes benchmarks: arithmetic, fan_in, fan_out, fork_join, identity, join, reachability, upcase
  - Data files for reachability benchmarks

## Running Benchmarks

```bash
cd benches
cargo bench
```

To run specific benchmarks:
```bash
cargo bench --bench arithmetic
```

## Performance Comparisons

These benchmarks enable performance comparisons with DFIR implementations in the main repository:

1. Run benchmarks here: `cargo bench`
2. Run DFIR benchmarks in main repo: `cd /path/to/bigweaver-agent-canary-hydro-zeta && cargo bench -p benches`
3. Compare criterion HTML reports in `target/criterion/` directories

## Code Style

This repository follows the same coding standards as the main repository:

* Use `rustfmt` for code formatting (config in `rustfmt.toml`)
* Use `clippy` for linting (config in `clippy.toml`)
* Follow conventional commits for commit messages

## Relationship to Main Repository

This repository was created to maintain clean separation of concerns by isolating heavy dependencies (timely-dataflow and differential-dataflow) from the main repository. This allows:

* Main repository to remain focused on core DFIR functionality
* Independent evolution of benchmark infrastructure
* Reduced build times and dependency overhead for main repository contributors
* Preserved ability to compare DFIR performance with timely/differential implementations
