# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on external dataflow frameworks such as timely-dataflow and differential-dataflow. These dependencies have been separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the core project lightweight and avoid unnecessary dependencies.

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks between DFIR and timely/differential-dataflow frameworks. See [benches/README.md](benches/README.md) for details.

Available benchmarks:
- arithmetic
- fan_in
- fan_out
- fork_join
- identity
- join
- reachability
- upcase

## Purpose

This repository serves two main purposes:

1. **Performance Comparison**: Allows comparison of DFIR performance against established dataflow frameworks
2. **Dependency Isolation**: Keeps heavy dependencies (timely-dataflow, differential-dataflow) separate from the main codebase

## Running Benchmarks

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run a specific benchmark
cargo bench -p benches --bench arithmetic
```

## Cross-Repository Integration

These benchmarks depend on `dfir_rs` and `sinktools` from the main repository. They are automatically fetched via git dependencies during the build process.

For DFIR-native benchmarks that don't require external framework comparisons, see the main repository's `benches/` directory.

## Contributing

When adding new benchmarks:
1. Place benchmark files in `benches/benches/`
2. Update `benches/Cargo.toml` to register the new benchmark
3. Update `benches/README.md` with benchmark description
4. Ensure benchmarks compare DFIR with timely/differential-dataflow where appropriate

## License

Apache-2.0 (same as the main Hydro project)