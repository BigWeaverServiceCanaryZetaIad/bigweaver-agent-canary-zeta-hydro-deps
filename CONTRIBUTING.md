# Contributing to Hydro Benchmarks

This repository contains benchmarks for comparing DFIR with timely and differential-dataflow frameworks.

## Repository Structure

This repository is organized into two main packages:

### benches
Contains benchmarks that compare DFIR implementations with Timely and Differential Dataflow implementations. Located in `benches/benches/`, includes:

* `arithmetic.rs` - Basic arithmetic operations comparison
* `fan_in.rs` - Fan-in pattern benchmarks
* `fan_out.rs` - Fan-out pattern benchmarks
* `fork_join.rs` - Fork-join pattern benchmarks
* `futures.rs` - Async futures benchmarks
* `identity.rs` - Identity operation benchmarks
* `join.rs` - Join operation benchmarks
* `micro_ops.rs` - Micro operations benchmarks
* `reachability.rs` - Graph reachability benchmarks (includes differential-dataflow comparison)
* `symmetric_hash_join.rs` - Symmetric hash join benchmarks
* `upcase.rs` - String case conversion benchmarks
* `words_diamond.rs` - Word processing diamond pattern benchmarks

### timely-differential-benches
Contains standalone benchmarks for Timely and Differential Dataflow frameworks only (without DFIR). Located in `timely-differential-benches/benches/`, currently includes:

* `reachability.rs` - Graph reachability using only Timely and Differential implementations
* `join.rs` - Hash join using only Timely implementation

## Running Benchmarks

### DFIR Comparison Benchmarks

Run all DFIR comparison benchmarks:
```bash
cargo bench -p benches
```

Run specific DFIR comparison benchmarks:
```bash
cargo bench -p benches --bench reachability
```

Filter benchmarks by framework name:
```bash
cargo bench -p benches -- dfir
cargo bench -p benches -- timely
cargo bench -p benches -- differential
```

### Timely/Differential Standalone Benchmarks

Run all Timely/Differential standalone benchmarks:
```bash
cargo bench -p timely-differential-benches
```

Run specific Timely/Differential benchmarks:
```bash
cargo bench -p timely-differential-benches --bench reachability
cargo bench -p timely-differential-benches --bench join
```

### All Benchmarks

Run all benchmarks across both packages:
```bash
cargo bench
```

## Adding New Benchmarks

### To the benches package (DFIR comparisons)

1. Create a new `.rs` file in `benches/benches/`
2. Implement benchmark functions for each framework you want to compare
3. Add a `[[bench]]` section in `benches/Cargo.toml`
4. Follow the existing benchmark patterns using criterion

### To the timely-differential-benches package

1. Create a new `.rs` file in `timely-differential-benches/benches/`
2. Implement only Timely and/or Differential Dataflow benchmarks (no DFIR)
3. Add a `[[bench]]` section in `timely-differential-benches/Cargo.toml`
4. Follow the existing benchmark patterns using criterion
5. Copy any required data files to `timely-differential-benches/benches/`

## Dependencies

The benchmarks depend on packages from the main Hydro repository. These are referenced via git dependencies in the `Cargo.toml` files.

### benches package dependencies
- `dfir_rs` - Main DFIR package (from main Hydro repository)
- `sinktools` - Utilities (from main Hydro repository)
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `criterion` - Benchmarking framework

### timely-differential-benches package dependencies
- `timely` (timely-master) - Timely Dataflow framework
- `differential-dataflow` (differential-dataflow-master) - Differential Dataflow framework
- `criterion` - Benchmarking framework

