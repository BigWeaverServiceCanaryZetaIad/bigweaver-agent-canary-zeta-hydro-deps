# Contributing to bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that depend on `timely` and `differential-dataflow`. These benchmarks were separated from the main Hydro repository to avoid unnecessary dependencies.

## Repository Structure

```
.
├── benches/               # Benchmark suite
│   ├── benches/          # Individual benchmark files
│   ├── Cargo.toml        # Benchmark dependencies
│   ├── README.md         # Benchmark documentation
│   └── MIGRATION.md      # Migration details
├── Cargo.toml            # Workspace configuration
└── README.md             # Repository overview
```

## Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing benchmark structure using criterion
4. Update `benches/README.md` to document the new benchmark

Example benchmark entry in Cargo.toml:
```toml
[[bench]]
name = "my_benchmark"
harness = false
```

## Running Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench reachability

# Run with baseline for comparison
cargo bench -- --save-baseline my-baseline
cargo bench -- --baseline my-baseline
```

## Dependencies

This repository specifically contains code that depends on:
- `timely-master` (version 0.13.0-dev.1)
- `differential-dataflow-master` (version 0.13.0-dev.1)

If your benchmark doesn't depend on these packages, it should remain in the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository.

## Code Style

Follow the same code style as the main Hydro repository:
- Use `rustfmt` for formatting
- Use `clippy` for linting
- Follow Rust naming conventions

## Testing

Before submitting changes:
1. Ensure benchmarks compile: `cargo check --benches`
2. Run benchmarks to verify functionality: `cargo bench`
3. Check for any warnings or errors

## Related Documentation

- Main repository: [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- Migration documentation: [benches/MIGRATION.md](./benches/MIGRATION.md)
