# Contributing to Hydro Deps

This repository contains performance benchmarks and dependencies for the Hydro project that require timely-dataflow and differential-dataflow.

## Repository Structure

- **benches/**: Performance benchmarks using timely-dataflow and differential-dataflow

## Running Benchmarks

### Prerequisites

- Rust toolchain (see rust-toolchain.toml in the main Hydro repository)
- Cargo

### Running All Benchmarks

```bash
cargo bench -p benches
```

### Running Specific Benchmarks

```bash
cargo bench -p benches --bench <benchmark-name>
```

Example:
```bash
cargo bench -p benches --bench reachability
```

## Adding New Benchmarks

1. Create a new benchmark file in `benches/benches/<benchmark-name>.rs`
2. Follow the existing benchmark patterns using criterion
3. Add the benchmark configuration to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "<benchmark-name>"
   harness = false
   ```
4. Test your benchmark locally
5. Submit a pull request

## Benchmark Guidelines

- Use criterion for all benchmarks
- Include clear descriptions and documentation
- Follow existing naming conventions
- Ensure benchmarks are deterministic where possible
- Add any required data files to the benches/benches/ directory

## Dependencies

Benchmarks reference the main Hydro repository via git dependencies for:
- `dfir_rs`: Core dataflow runtime
- `sinktools`: Utility tools

These are automatically fetched from the main repository to ensure compatibility.

## Submitting Changes

### Pull Requests

Follow the [Conventional Commits specification](https://www.conventionalcommits.org/) for PR titles and descriptions.

Example PR titles:
- `feat(benches): add new join benchmark`
- `fix(benches): correct timing in reachability benchmark`
- `perf(benches): optimize memory usage in diamond benchmark`

## Questions?

For questions about the main Hydro project, see the [main repository](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta).
