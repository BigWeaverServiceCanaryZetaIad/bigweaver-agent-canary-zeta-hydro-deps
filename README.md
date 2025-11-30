# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on `timely` and `differential-dataflow` packages, separated from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain cleaner dependency management.

## Benchmarks

This repository includes microbenchmarks of Hydro and other crates that specifically require timely-dataflow and differential-dataflow dependencies.

### Prerequisites

This repository depends on crates from the main `bigweaver-agent-canary-hydro-zeta` repository. Ensure both repositories are cloned as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench identity
cargo bench --bench arithmetic
```

### Available Benchmarks

- **arithmetic**: Arithmetic operation benchmarks
- **fan_in**: Fan-in pattern benchmarks
- **fan_out**: Fan-out pattern benchmarks
- **fork_join**: Fork-join pattern benchmarks
- **futures**: Futures-based async benchmarks
- **identity**: Identity operation benchmarks
- **join**: Join operation benchmarks
- **micro_ops**: Micro-operation benchmarks
- **reachability**: Graph reachability benchmarks
- **symmetric_hash_join**: Symmetric hash join benchmarks
- **upcase**: String uppercase benchmarks
- **words_diamond**: Word processing diamond pattern benchmarks

### Performance Comparisons

To compare performance across different implementations:

1. Run benchmarks in this repository:
   ```bash
   cargo bench
   ```

2. Results are stored in `target/criterion/` directory with detailed HTML reports

3. To compare against baseline, run benchmarks before and after changes, and Criterion will automatically show the comparison

### Notes

- Wordlist data file (`words_alpha.txt`) is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- These benchmarks were separated from the main repository to avoid unnecessary dependencies on timely and differential-dataflow in the core Hydro project
