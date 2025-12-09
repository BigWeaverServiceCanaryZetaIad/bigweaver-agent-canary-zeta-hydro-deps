# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that were separated from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Purpose

This repository serves as a dedicated location for:

1. **Timely and differential-dataflow benchmarks**: Performance comparison benchmarks that test Hydro/DFIR against timely and differential-dataflow implementations
2. **Isolated dependency management**: Keeps timely and differential-dataflow dependencies separate from the main repository

## Structure

- **benches/**: Microbenchmarks comparing Hydro performance with timely and differential-dataflow

## Why Separate?

The main Hydro repository no longer needs to carry timely and differential-dataflow as dependencies. By moving the benchmarks here, we:

- Reduce dependency bloat in the main repository
- Maintain the ability to run performance comparisons
- Keep benchmark code organized and accessible
- Allow independent versioning of benchmark dependencies

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability
```

For more details on available benchmarks, see [benches/README.md](benches/README.md).

## Integration with Main Repository

These benchmarks reference the main repository's crates (`dfir_rs`, `sinktools`) as git dependencies, ensuring they always test against the current state of the main codebase.

## Contributing

When adding new benchmarks that compare Hydro performance with timely or differential-dataflow:

1. Add benchmark files to `benches/benches/`
2. Register the benchmark in `benches/Cargo.toml`
3. Update documentation as needed
4. Ensure benchmarks work with both local and CI environments