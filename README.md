# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external dataflow libraries (timely-dataflow and differential-dataflow).

## Purpose

This repository was created to separate external dataflow dependencies from the main `bigweaver-agent-canary-hydro-zeta` repository. By moving timely and differential-dataflow benchmarks here, the main codebase remains free of these dependencies while still maintaining the ability to run performance comparisons.

## Contents

### Benchmarks

The `benches/` directory contains benchmarks comparing DFIR with timely-dataflow and differential-dataflow implementations:

- Arithmetic operations
- Fan-in and fan-out patterns
- Fork-join patterns
- Identity operations
- String operations (upcase)
- Join operations
- Graph reachability (using differential-dataflow)

See [benches/README.md](benches/README.md) for detailed information on running the benchmarks.

## Dependencies

This repository depends on:
- `timely-dataflow` - For push-based dataflow benchmarks
- `differential-dataflow` - For incremental computation benchmarks
- `bigweaver-agent-canary-hydro-zeta` - For DFIR implementations (via path dependencies)

## Running Benchmarks

```bash
cd benches
cargo bench
```

Results will be available in `target/criterion/` as HTML reports.

## Relationship with Main Repository

This is a companion repository to `bigweaver-agent-canary-hydro-zeta`. When making changes to DFIR implementations that may affect benchmark results, consider running benchmarks in both repositories to ensure performance comparisons remain valid.