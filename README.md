# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on timely-dataflow and differential-dataflow packages, which have been separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency boundaries.

## Purpose

The benchmarks in this repository compare the performance of dfir_rs (Hydroflow) against timely-dataflow and differential-dataflow implementations. This separation allows:

- Clean dependency management in the main repository
- Independent performance testing and comparison
- Isolation of external dataflow dependencies

## Benchmarks

The following benchmarks are included:

### Timely/Differential-Dataflow Dependent Benchmarks
- **fan_in.rs** - Tests fan-in dataflow patterns with timely-dataflow
- **upcase.rs** - Tests string transformation operations with timely-dataflow  
- **reachability.rs** - Tests graph reachability algorithms with differential-dataflow

### Additional Benchmarks
- arithmetic.rs
- fan_out.rs
- fork_join.rs
- futures.rs
- identity.rs
- join.rs
- micro_ops.rs
- symmetric_hash_join.rs
- words_diamond.rs

## Setup

These benchmarks require access to the main bigweaver-agent-canary-hydro-zeta repository for dfir_rs and sinktools dependencies.

Clone both repositories as siblings:

```bash
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

## Running Benchmarks

To run the benchmarks:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench fan_in
cargo bench --bench upcase
cargo bench --bench reachability
```

## Dependencies

- **timely-master** (0.13.0-dev.1) - Timely dataflow system
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow operators
- **dfir_rs** - Hydroflow implementation (from sibling repository)
- **criterion** - Benchmarking framework

## Performance Comparison

These benchmarks enable performance comparisons between:
- Hydroflow (dfir_rs) surface syntax
- Timely dataflow
- Raw Rust iterators
- Standard loops

Results help guide optimization efforts and validate Hydroflow's performance characteristics.