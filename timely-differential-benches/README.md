# Timely and Differential-Dataflow Benchmarks

This package contains benchmarks that depend on `timely-dataflow` and `differential-dataflow`. These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to isolate the heavy dependencies.

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs**: Basic arithmetic operations across dataflow systems
- **fan_in.rs**: Multiple input streams merging into one
- **fan_out.rs**: Single stream splitting into multiple outputs
- **fork_join.rs**: Fork and join patterns
- **identity.rs**: Identity transformation (passthrough)
- **join.rs**: Join operations between streams
- **reachability.rs**: Graph reachability computation (includes data files)
- **upcase.rs**: String transformation operations

## Running Benchmarks

To run all benchmarks:

```bash
cd timely-differential-benches
cargo bench
```

To run a specific benchmark:

```bash
cargo bench --bench arithmetic
```

## Cross-Repository Comparisons

To compare these benchmarks with implementations in the main `bigweaver-agent-canary-hydro-zeta` repository:

1. Clone both repositories side-by-side:
```bash
git clone <url>/bigweaver-agent-canary-hydro-zeta.git
git clone <url>/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Edit `Cargo.toml` in this package and uncomment the path dependencies:
```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

3. Run benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

## Dependencies

- `timely-dataflow`: Low-latency data-parallel dataflow system
- `differential-dataflow`: Incremental computation framework
- `criterion`: Benchmarking framework
- Optional path dependencies: `dfir_rs`, `sinktools` (from main repository)
