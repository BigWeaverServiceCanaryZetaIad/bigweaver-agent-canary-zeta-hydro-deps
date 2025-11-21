# Timely and Differential Dataflow Benchmarks

This directory contains benchmarks for comparing performance of timely and differential-dataflow implementations.

## Overview

These benchmarks were separated from the main bigweaver-agent-canary-hydro-zeta repository to isolate the timely and differential-dataflow dependencies. This allows the main repository to avoid these heavy dependencies while still maintaining performance comparison capabilities.

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs**: Arithmetic operation pipelines comparing timely with raw implementations
- **fan_in.rs**: Fan-in dataflow patterns (multiple inputs, single output)
- **fan_out.rs**: Fan-out dataflow patterns (single input, multiple outputs)  
- **fork_join.rs**: Fork-join patterns with branching and merging
- **identity.rs**: Identity/passthrough operations
- **join.rs**: Join operations between two streams
- **reachability.rs**: Graph reachability algorithm using timely and differential-dataflow
- **upcase.rs**: String transformation operations

## Running Benchmarks

To run all benchmarks:

```bash
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
```

## Comparing with Hydroflow

The main bigweaver-agent-canary-hydro-zeta repository contains corresponding Hydroflow implementations of these benchmarks. To compare performance:

1. Run the benchmarks in this repository: `cargo bench`
2. Run the benchmarks in the main repository: `cd ../bigweaver-agent-canary-hydro-zeta/benches && cargo bench`
3. Compare the results in the generated `target/criterion` directories

Both repositories use Criterion.rs which generates HTML reports in `target/criterion/` that can be used for detailed performance comparisons.

## Architecture

These benchmarks focus solely on timely/differential-dataflow implementations, while the main repository focuses on Hydroflow (dfir_rs) implementations. This separation:

- Reduces build times for the main repository
- Isolates heavy dependencies
- Maintains clear performance comparison capabilities
- Allows independent evolution of each benchmark suite
