# DFIR Comparative Benchmarks

Benchmarks comparing DFIR (Dataflow Intermediate Representation) with timely-dataflow and differential-dataflow.

## Overview

This directory contains benchmarks that compare DFIR implementations with equivalent implementations using timely-dataflow and differential-dataflow. These benchmarks help track DFIR's performance relative to established dataflow frameworks.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench join
```

## Available Benchmarks

- **arithmetic** - Pipeline of arithmetic operations
- **fan_in** - Multiple inputs merging to single output
- **fan_out** - Single input splitting to multiple outputs  
- **fork_join** - Parallel processing with synchronization
- **identity** - Passthrough/identity operations
- **join** - Relational join operations
- **micro_ops** - Fine-grained micro-operations
- **reachability** - Graph reachability computation
- **symmetric_hash_join** - Hash-based join operations
- **upcase** - String transformation operations
- **words_diamond** - Complex word processing pipeline

## Dependencies

These benchmarks depend on:
- **dfir_rs** - DFIR runtime from the main repository
- **timely-dataflow** - Timely dataflow framework
- **differential-dataflow** - Differential dataflow framework
- **criterion** - Benchmarking framework

## Notes

- Wordlist for word benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Benchmark results are written to `target/criterion/`
- These benchmarks are maintained separately from the main repository to keep external dependencies isolated

