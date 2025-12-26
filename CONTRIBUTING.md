# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains performance comparison benchmarks for timely and differential-dataflow packages that were separated from the main bigweaver-agent-canary-hydro-zeta repository.

## Repository Structure

* `benches/` contains benchmarks comparing Hydroflow (DFIR) performance with Timely Dataflow and Differential Dataflow implementations.

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p timely-differential-benches
```

To run specific benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

## Code Quality

This repository uses the same code quality standards as the main Hydro repository:

```bash
# Format code
cargo fmt

# Check formatting
cargo fmt --check

# Run lints
cargo clippy --all-targets -- -D warnings
```

## Purpose

These benchmarks enable performance comparison testing between Hydroflow and other dataflow frameworks without adding those dependencies to the main repository. This maintains a clean separation of concerns and reduces dependency complexity in the primary codebase.

## Related Repositories

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro)
