# Migration Notes

## Benchmarks Moved from bigweaver-agent-canary-hydro-zeta

The following benchmarks were moved from the main Hydroflow repository to this dedicated repository:

### Moved Benchmark Files

1. **arithmetic.rs** - Basic arithmetic operations comparison between Hydroflow and Timely
2. **fan_in.rs** - Fan-in pattern (multiple inputs converging to single output)
3. **fan_out.rs** - Fan-out pattern (single input spreading to multiple outputs)
4. **fork_join.rs** - Fork-join parallelism pattern comparison
5. **identity.rs** - Identity transformation pipeline benchmarks
6. **join.rs** - Join operations performance comparison
7. **reachability.rs** - Graph reachability using Timely, Differential Dataflow, and Hydroflow
8. **upcase.rs** - String uppercase transformation operations

### Supporting Files

- **reachability_edges.txt** - Graph edge data for reachability benchmark
- **reachability_reachable.txt** - Expected reachable nodes for validation
- **build.rs** - Build script for generating code

## Removed Dependencies

The following dependencies were removed from the main repository's `benches/Cargo.toml`:

- `timely` (package: "timely-master", version: "0.13.0-dev.1")
- `differential-dataflow` (package: "differential-dataflow-master", version: "0.13.0-dev.1")

These dependencies are now isolated to this repository.

## Retained Benchmarks

The following benchmarks remain in the main Hydroflow repository as they don't depend on timely/differential-dataflow:

- **micro_ops.rs** - Micro-operation benchmarks for Hydroflow primitives
- **symmetric_hash_join.rs** - Symmetric hash join benchmarks
- **words_diamond.rs** - Diamond pattern word processing benchmarks
- **futures.rs** - Async futures benchmarks

## Purpose of Separation

This separation serves multiple purposes:

1. **Dependency Isolation**: Keeps external dataflow framework dependencies separate from core Hydroflow
2. **Independent Versioning**: Allows benchmarks to evolve independently from core development
3. **Clean Builds**: Reduces build time and complexity for core repository
4. **Focused Comparisons**: Provides dedicated space for performance comparison work
5. **Maintenance**: Makes it easier to update or remove comparative benchmarks without affecting core

## Performance Comparison Functionality

All performance comparison functionality has been retained:

- Criterion benchmark harness with async support and HTML reports
- Hydroflow (`dfir_rs`) integration for baseline comparisons
- Timely Dataflow integration for low-latency streaming comparisons
- Differential Dataflow integration for incremental computation comparisons
- Full benchmark configuration and reporting capabilities

## Running Migrated Benchmarks

From this repository:

```bash
# Run all performance comparison benchmarks
cargo bench

# Run specific framework comparisons
cargo bench --bench reachability  # Compare all three: Hydroflow, Timely, Differential
cargo bench --bench arithmetic    # Compare Hydroflow vs Timely
cargo bench --bench join          # Compare join implementations

# Generate HTML reports (automatically created in target/criterion/)
cargo bench
```

## Integration with Original Repository

These benchmarks are designed to work independently but can still compare against the latest Hydroflow by:

1. Using git dependency to pull latest Hydroflow: `dfir_rs = { git = "https://github.com/hydro-project/hydro", version = "0.10" }`
2. Or using local path if needed: `dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs" }`

## CI/CD Considerations

The main repository's benchmark CI workflow continues to run remaining benchmarks. If you want to run these migrated benchmarks in CI, you would need to:

1. Set up a separate workflow in this repository
2. Configure similar Criterion output parsing
3. Optionally publish results to a separate gh-pages location

## Date of Migration

This migration was performed on December 25, 2025.
