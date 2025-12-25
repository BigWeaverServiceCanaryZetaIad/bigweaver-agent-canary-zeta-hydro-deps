# Timely/Differential-Dataflow Benchmarks

This repository contains benchmarks that use timely and differential-dataflow dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench upcase
```

## Cross-Repository Benchmark Comparisons

These benchmarks depend on the `dfir_rs` and `sinktools` crates from the sibling repository `bigweaver-agent-canary-hydro-zeta`. 

To run comparisons between benchmarks in both repositories:

1. Ensure both repositories are cloned in the same parent directory:
   ```
   parent-dir/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

2. Run benchmarks in this repository:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

3. Run benchmarks in the main repository:
   ```bash
   cd ../bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   ```

4. Compare results from the `target/criterion` directories in each repository.

## Benchmark Descriptions

### Timely Benchmarks
- **arithmetic**: Tests arithmetic operations using timely operators
- **fan_in**: Tests concatenation of multiple streams
- **fan_out**: Tests splitting a stream to multiple consumers
- **fork_join**: Tests forking and joining data flows
- **identity**: Tests identity mapping operations
- **join**: Tests join operations using timely operators
- **upcase**: Tests string transformation operations

### Differential-Dataflow Benchmarks
- **reachability**: Tests graph reachability using differential-dataflow iterative computation
