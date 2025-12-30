# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow dependencies that were extracted from the bigweaver-agent-canary-hydro-zeta repository.

## Purpose

This repository isolates performance benchmarks that depend on the `timely` and `differential-dataflow` packages. By separating these benchmarks, the main bigweaver-agent-canary-hydro-zeta repository can avoid these dependencies while still maintaining the ability to run comparative performance tests.

## Benchmarks

The following benchmarks are available:

### Pure Timely/Differential Benchmarks
- **join.rs** - Hash join operations using timely dataflow
- **upcase.rs** - String manipulation operations using timely dataflow

### Comparative Benchmarks (Timely/Differential portions)
- **arithmetic.rs** - Arithmetic operations with timely implementation
- **fan_in.rs** - Fan-in dataflow patterns with timely implementation
- **fan_out.rs** - Fan-out dataflow patterns with timely implementation
- **fork_join.rs** - Fork-join patterns with timely implementation
- **identity.rs** - Identity dataflow operations with timely implementation
- **reachability.rs** - Graph reachability with timely and differential-dataflow implementations

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench join
```

## Performance Comparisons

To compare performance between timely/differential-dataflow and hydroflow/dfir_rs implementations:

1. Run benchmarks in this repository (timely/differential):
   ```bash
   cargo bench -p benches --bench arithmetic
   ```

2. Run corresponding benchmarks in bigweaver-agent-canary-hydro-zeta (hydroflow):
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches --bench arithmetic
   ```

3. Compare the results from both runs. Criterion will generate HTML reports in `target/criterion/` for detailed analysis.

## Benchmark Data Files

Some benchmarks use data files located in `benches/benches/`:
- `reachability_edges.txt` - Graph edges for reachability benchmark
- `reachability_reachable.txt` - Expected reachable vertices
- `words_alpha.txt` - Word list for string processing benchmarks

## Related Repository

The hydroflow/dfir_rs implementations of these benchmarks are maintained in:
- [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta)
