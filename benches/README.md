# Microbenchmarks

Performance benchmarks comparing Hydroflow with Timely Dataflow and Differential Dataflow implementations.

**Note:** These benchmarks have been moved to this repository ([bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)) from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce dependency bloat and improve build times.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench arithmetic
```

## Available Benchmarks

- **arithmetic** - Basic arithmetic operations
- **fan_in** - Fan-in dataflow patterns
- **fan_out** - Fan-out dataflow patterns
- **fork_join** - Fork-join patterns
- **identity** - Identity operations
- **upcase** - String uppercase operations
- **join** - Join operations
- **reachability** - Graph reachability algorithms
- **micro_ops** - Micro-operation benchmarks
- **symmetric_hash_join** - Symmetric hash join operations
- **words_diamond** - Word processing diamond pattern
- **futures** - Future-based operations

## Dependencies

These benchmarks require `timely` and `differential-dataflow` packages, which is why they're maintained in this separate repository.

---

*Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt*
