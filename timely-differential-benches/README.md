# Timely and Differential-Dataflow Benchmarks

This directory contains benchmarks that depend on timely-dataflow and differential-dataflow. These benchmarks were migrated from the `bigweaver-agent-canary-hydro-zeta` repository to isolate these heavy dependencies.

## Benchmarks

The following benchmarks are included:

- **arithmetic.rs**: Arithmetic operations benchmark
- **fan_in.rs**: Fan-in pattern benchmark
- **fan_out.rs**: Fan-out pattern benchmark
- **fork_join.rs**: Fork-join pattern benchmark
- **identity.rs**: Identity/passthrough benchmark
- **join.rs**: Join operations benchmark
- **reachability.rs**: Graph reachability benchmark (includes data files)
- **upcase.rs**: String uppercase transformation benchmark

## Running Benchmarks

### Standalone (Timely/Differential only)

To run benchmarks that only use timely-dataflow and differential-dataflow:

```bash
cd timely-differential-benches
cargo bench
```

### Cross-Repository Comparison

To run performance comparisons between timely/differential-dataflow and other implementations (babyflow, hydroflow, spinachflow):

1. **Clone both repositories side-by-side**:
   ```bash
   git clone <repository-url>/bigweaver-agent-canary-hydro-zeta.git
   git clone <repository-url>/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Configure path dependencies**:
   Edit `Cargo.toml` and uncomment the path dependencies at the bottom:
   ```toml
   babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
   spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
   ```

3. **Run benchmarks**:
   ```bash
   cd timely-differential-benches
   cargo bench
   ```

## Performance Comparison

The benchmarks compare the performance of different dataflow implementations:

- **timely-dataflow**: Low-latency data-parallel dataflow system
- **differential-dataflow**: Incremental computation based on timely-dataflow
- **babyflow**: Custom dataflow implementation (requires path dependency)
- **hydroflow**: Alternative dataflow implementation (requires path dependency)
- **spinachflow**: Another dataflow implementation variant (requires path dependency)

## Migration Notes

These benchmarks were migrated from `bigweaver-agent-canary-hydro-zeta/benches` to:
- Reduce dependencies in the main repository
- Improve build times for the main codebase
- Maintain the ability to run performance comparisons
- Keep the main repository focused on core functionality

For migration details, see the MIGRATION.md file in the root of this repository.
