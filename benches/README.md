# Hydro Benchmarks

Benchmarks for Hydro and related crates.

## Overview

This directory contains benchmarks that were migrated from the main bigweaver-agent-canary-hydro-zeta repository to isolate benchmark dependencies and improve build times.

## Available Benchmarks

- **micro_ops** - Micro-operations benchmark
- **symmetric_hash_join** - Symmetric hash join benchmark
- **words_diamond** - Word processing diamond pattern benchmark
- **futures** - Futures-based operations benchmark

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
