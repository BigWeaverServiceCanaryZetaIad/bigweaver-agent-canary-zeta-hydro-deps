# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that compare Hydro/DFIR with external dataflow frameworks (timely-dataflow and differential-dataflow).

## Purpose

This repository was created to separate performance comparison benchmarks from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation allows us to:

1. **Avoid unnecessary dependencies**: The main Hydro repository doesn't need timely-dataflow or differential-dataflow as dependencies
2. **Maintain comparison capabilities**: Performance comparisons with external frameworks remain available for evaluation
3. **Clean architecture**: Core functionality is kept separate from external framework integrations

## Contents

### Benchmarks (`benches/`)

Performance comparison benchmarks between DFIR/Hydro and other dataflow frameworks:
- timely-dataflow comparisons
- differential-dataflow comparisons
- Various dataflow pattern benchmarks (fan-in, fan-out, join, etc.)

See [benches/README.md](benches/README.md) for detailed documentation on running and interpreting benchmarks.

## Quick Start

### Running Benchmarks

```bash
# Run all comparison benchmarks
cargo bench -p hydro-deps-benches

# Run a specific benchmark
cargo bench -p hydro-deps-benches --bench reachability

# Run benchmarks for a specific framework
cargo bench -p hydro-deps-benches --bench fan_in -- dfir
cargo bench -p hydro-deps-benches --bench fan_in -- timely
```

### Viewing Results

Benchmark results are saved in HTML format:
```bash
open target/criterion/report/index.html
```

## Relationship to Main Repository

This repository complements the main `bigweaver-agent-canary-hydro-zeta` repository:

- **Main Repository**: Contains core Hydro/DFIR implementation and native benchmarks
- **This Repository**: Contains external framework comparisons and dependency-heavy benchmarks

Both repositories should be kept in sync when making changes that affect benchmark interfaces or APIs.

## Contributing

When adding new comparison benchmarks:
1. Add benchmark files to `benches/benches/`
2. Update `benches/Cargo.toml` with the new benchmark declaration
3. Document the benchmark purpose in `benches/README.md`
4. Ensure benchmarks run successfully with `cargo bench`

## License

Apache-2.0 (same as the main Hydro repository)