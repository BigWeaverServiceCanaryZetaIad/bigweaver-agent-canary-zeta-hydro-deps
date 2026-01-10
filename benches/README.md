# Timely/Differential-Dataflow Comparison Benchmarks

Performance comparison benchmarks for Hydro against timely-dataflow and differential-dataflow.

These benchmarks have been separated from the main Hydro repository to keep the main repository's dependency footprint lean while retaining the ability to run performance comparisons.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
cargo bench -p benches --bench join
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench fan_in
cargo bench -p benches --bench fan_out
cargo bench -p benches --bench fork_join
cargo bench -p benches --bench upcase
```

## About

These benchmarks reference the main Hydro repository as a git dependency to ensure they test against the latest Hydro code while maintaining the ability to run performance comparisons with timely-dataflow and differential-dataflow.
