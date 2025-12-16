# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that require external frameworks like Timely Dataflow and Differential Dataflow.

## Purpose

This repository was created to separate performance benchmarks that depend on `timely` and `differential-dataflow` from the main `bigweaver-agent-canary-hydro-zeta` repository. This separation provides several benefits:

1. **Reduced Build Dependencies**: The main repository no longer needs to compile timely and differential-dataflow, significantly reducing build times
2. **Cleaner Dependency Management**: External comparison dependencies are isolated from the core Hydro implementation
3. **Maintained Performance Comparisons**: All performance comparison functionality between Hydro and other frameworks remains accessible

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro implementations with Timely Dataflow and Differential Dataflow:

- **arithmetic**: Arithmetic operation performance
- **fan_in**: Fan-in dataflow pattern performance
- **fan_out**: Fan-out dataflow pattern performance
- **fork_join**: Fork-join pattern performance
- **identity**: Identity operation performance
- **join**: Join operation performance
- **reachability**: Graph reachability computation
- **upcase**: String case conversion performance

## Usage

To run the benchmarks:

```bash
cd benches
cargo bench
```

For more detailed benchmark documentation, see [benches/README.md](benches/README.md).

## Relationship to Main Repository

This repository works alongside the main `bigweaver-agent-canary-hydro-zeta` repository:

- The main repository contains the core Hydro implementation
- This repository contains external dependency benchmarks for performance comparisons
- Benchmark code references Hydro components (dfir_rs, sinktools) from the main repository via git dependencies

## Development

When updating benchmarks or adding new performance comparisons:

1. Make changes to benchmark files in `benches/benches/`
2. Update dependencies in `benches/Cargo.toml` if needed
3. Run benchmarks locally to verify functionality
4. Document any new benchmarks in this README and `benches/README.md`