# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for timely and differential-dataflow that were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to avoid unnecessary dependencies in the main codebase.

## Benchmarks

This repository contains performance benchmarks for Hydro that depend on timely and differential-dataflow packages. These benchmarks were originally part of the main repository but were moved here to maintain a cleaner separation of concerns and avoid dependency bloat.

### Available Benchmarks

The following benchmarks are included in this repository:

#### Timely-based benchmarks:
- **arithmetic.rs** - Tests arithmetic operations and data flow through pipeline stages
- **fan_in.rs** - Measures performance of fan-in patterns where multiple streams converge
- **fan_out.rs** - Measures performance of fan-out patterns where streams diverge
- **fork_join.rs** - Tests fork-join parallelism patterns with filtering operations
- **identity.rs** - Baseline benchmark for identity operations (no transformation)
- **join.rs** - Tests join operations between data streams
- **upcase.rs** - String transformation operations (uppercase conversion)

#### Differential-dataflow-based benchmarks:
- **reachability.rs** - Graph reachability computation using differential dataflow

### Data Files

The benchmarks use the following data files:
- `benches/reachability_edges.txt` - Edge data for reachability benchmark
- `benches/reachability_reachable.txt` - Expected reachable nodes for validation

Generated files (created at build time):
- `benches/fork_join_*.hf` - Generated Hydro code for fork_join benchmark

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmarks

```bash
# Run a single benchmark
cargo bench --bench arithmetic

# Run multiple specific benchmarks
cargo bench --bench fan_in --bench fan_out

# Run benchmarks matching a pattern
cargo bench arithmetic
```

### Benchmark Output

Benchmarks use [Criterion.rs](https://github.com/bheisler/criterion.rs) which provides:
- Statistical analysis of benchmark results
- HTML reports with graphs and comparisons
- Detection of performance regressions

Results are stored in `target/criterion/` directory. Open `target/criterion/report/index.html` in a browser to view detailed reports.

## Performance Comparisons

To compare performance across different versions or configurations:

1. **Baseline run**: Run benchmarks to establish a baseline
   ```bash
   cargo bench
   ```

2. **Make changes**: Modify code or configuration

3. **Comparison run**: Run benchmarks again
   ```bash
   cargo bench
   ```

4. **View results**: Criterion automatically compares against the previous baseline and reports changes in the console and HTML reports.

### Comparing with Main Repository Benchmarks

The main bigweaver-agent-canary-hydro-zeta repository contains additional benchmarks that don't depend on timely/differential-dataflow:
- `futures.rs`
- `micro_ops.rs`
- `symmetric_hash_join.rs`
- `words_diamond.rs`

Both repositories use the same criterion version and configuration for consistency in performance comparisons.

## Dependencies

This repository depends on:

- **timely** (package: timely-master, version 0.13.0-dev.1) - Core timely dataflow engine
- **differential-dataflow** (package: differential-dataflow-master, version 0.13.0-dev.1) - Incremental computation framework
- **dfir_rs** - Hydro's dataflow intermediate representation (from main repository)
- **criterion** - Benchmarking framework with statistical analysis
- **sinktools** - Utility crate from main repository

### Dependency Sources

Since this is a separate repository from the main Hydro project, dependencies on `dfir_rs` and `sinktools` are pulled from the main repository via git:

```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro.git", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro.git", version = "^0.0.1" }
```

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                          # This file
└── benches/                           # Benchmark package
    ├── Cargo.toml                     # Package configuration
    ├── build.rs                       # Build script (generates fork_join code)
    └── benches/                       # Benchmark implementations
        ├── .gitignore
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Migration History

These benchmarks were moved from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner codebase and avoid unnecessary dependencies. The migration ensures:

- Main repository stays focused on core Hydro functionality
- Timely/differential-dataflow dependencies are isolated
- Performance testing capabilities are fully retained
- Benchmark structure and functionality remain unchanged

## Contributing

When adding new benchmarks:

1. Create a new `.rs` file in `benches/benches/`
2. Add a corresponding `[[bench]]` entry in `benches/Cargo.toml`
3. Follow existing benchmark patterns using Criterion.rs
4. Add documentation about what the benchmark measures
5. Update this README with the new benchmark information

## License

Apache-2.0