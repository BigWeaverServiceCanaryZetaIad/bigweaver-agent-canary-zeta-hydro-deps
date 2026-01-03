# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks comparing Hydro with [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow) and [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow).

These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to maintain a cleaner separation of concerns and minimize dependencies in the main codebase.

## Benchmarks

This repository includes the following benchmarks:

- **fan_in** - Compares fan-in/union operations across Hydro, Timely Dataflow, and plain Rust iterators
- **join** - Benchmarks join operations with different data types (usize and String) comparing Timely Dataflow with plain Rust solutions
- **reachability** - Graph reachability benchmarks comparing Hydro, Timely Dataflow, and Differential Dataflow implementations

## Running Benchmarks

### Prerequisites

Ensure you have Rust and Cargo installed. These benchmarks require the nightly Rust toolchain as they depend on the main Hydro repository.

### Run All Benchmarks

```bash
cargo bench -p hydro-timely-differential-benches
```

### Run Specific Benchmarks

Run the fan_in benchmark:
```bash
cargo bench -p hydro-timely-differential-benches --bench fan_in
```

Run the join benchmark:
```bash
cargo bench -p hydro-timely-differential-benches --bench join
```

Run the reachability benchmark:
```bash
cargo bench -p hydro-timely-differential-benches --bench reachability
```

## Benchmark Results

Results will be generated in the `target/criterion` directory with HTML reports that can be viewed in a web browser.

## Dependencies

- **criterion** - Statistical benchmarking framework
- **dfir_rs** - Hydro's dataflow runtime (fetched from main repository)
- **timely** - Timely Dataflow framework
- **differential-dataflow** - Differential Dataflow framework

## Migration from Main Repository

These benchmarks were previously located in the `benches/benches` directory of the `bigweaver-agent-canary-hydro-zeta` repository. They have been moved here to:

1. Separate external framework dependencies (Timely/Differential) from the main codebase
2. Maintain the ability to run performance comparisons without cluttering the main repository
3. Allow independent versioning and maintenance of comparative benchmarks

## Contributing

When adding new comparative benchmarks against Timely Dataflow or Differential Dataflow, they should be added to this repository rather than the main Hydro repository.