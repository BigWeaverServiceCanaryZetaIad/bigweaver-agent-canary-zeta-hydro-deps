# Timely and Differential-Dataflow Benchmarks

This repository contains performance benchmarks for Hydro's dfir_rs alongside timely and differential-dataflow implementations. These benchmarks enable direct performance comparisons between different dataflow frameworks.

## Purpose

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to:
- Isolate dependencies on timely and differential-dataflow
- Maintain the ability to run performance comparisons
- Keep the main repository focused on core functionality

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench join
```

## Benchmarks Included

- **arithmetic** - Basic arithmetic operations across frameworks
- **fan_in** - Multiple inputs merging into one
- **fan_out** - One input splitting into multiple outputs
- **fork_join** - Fork and join patterns
- **identity** - Pass-through operations
- **join** - Join operations on streams
- **reachability** - Graph reachability (includes differential-dataflow)
- **upcase** - String uppercase operations
- **futures** - Async/futures performance
- **micro_ops** - Micro-level operations
- **symmetric_hash_join** - Symmetric hash join implementations
- **words_diamond** - Word processing in diamond patterns

## Dependencies

The benchmarks depend on:
- `timely-master` (v0.13.0-dev.1)
- `differential-dataflow-master` (v0.13.0-dev.1)
- `dfir_rs` (from main hydro repository)
- `criterion` (for benchmarking framework)

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
