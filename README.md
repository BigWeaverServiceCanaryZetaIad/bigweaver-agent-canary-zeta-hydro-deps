# bigweaver-agent-canary-zeta-hydro-deps

This repository contains development dependencies for the Hydro project, specifically benchmarks that depend on `timely` and `differential-dataflow`.

## Benchmarks

The `benches/` directory contains microbenchmarks for Hydro and related crates.

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench words_diamond
```

### Available Benchmarks

- **arithmetic.rs** - Uses timely dataflow for arithmetic operations
- **reachability.rs** - Uses timely and differential-dataflow for graph reachability
- **words_diamond.rs** - Word processing benchmark
- **fan_in.rs** - Fan-in pattern benchmark
- **fan_out.rs** - Fan-out pattern benchmark
- **fork_join.rs** - Fork-join pattern benchmark
- **futures.rs** - Futures-based benchmark
- **identity.rs** - Identity operation benchmark
- **join.rs** - Join operation benchmark
- **micro_ops.rs** - Micro-operations benchmark
- **symmetric_hash_join.rs** - Symmetric hash join benchmark
- **upcase.rs** - String uppercase benchmark

### Dependencies

The benchmarks depend on `dfir_rs` and `sinktools` from the main Hydro repository. These are referenced via path dependencies pointing to `../bigweaver-agent-canary-hydro-zeta/`.

### Note

Wordlist used in benchmarks is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
