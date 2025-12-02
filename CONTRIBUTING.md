# Contributing to Hydro Deps Repository

This repository contains benchmarks and code that depend on external dependencies like `timely-dataflow` and `differential-dataflow`. These were moved from the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository clean of these dependencies.

## Repository Structure

```
.
├── benches/          # Performance benchmarks
│   ├── benches/      # Benchmark source files
│   ├── Cargo.toml    # Benchmark dependencies
│   └── README.md     # Benchmark usage guide
├── Cargo.toml        # Workspace configuration
└── README.md         # Repository overview
```

## Running Benchmarks

To run all benchmarks:
```bash
cargo bench -p benches
```

To run a specific benchmark:
```bash
cargo bench -p benches --bench reachability
```

To save baseline results for comparison:
```bash
cargo bench -p benches -- --save-baseline my-baseline
```

To compare against a saved baseline:
```bash
cargo bench -p benches -- --baseline my-baseline
```

## Adding New Benchmarks

To add a new benchmark:

1. Create a new Rust file in `benches/benches/` (e.g., `benches/benches/my_benchmark.rs`)
2. Add a benchmark entry in `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Use the Criterion framework for your benchmark
4. Update `benches/README.md` with a description of the new benchmark
5. Update the main `README.md` to list the new benchmark

## Benchmark Guidelines

- Use meaningful names that describe what's being benchmarked
- Include comments explaining the benchmark's purpose
- Use appropriate sample sizes and warmup iterations
- Consider different input sizes where relevant
- Follow existing patterns from other benchmarks

## Dependencies

This repository includes:

- `timely-dataflow` (via `timely-master` package)
- `differential-dataflow` (via `differential-dataflow-master` package)
- `dfir_rs` - Core DFIR runtime
- `criterion` - Benchmarking framework

Dependencies are sourced from crates.io to maintain separation from the main repository.

## Testing Changes

Before submitting changes:

1. Ensure all benchmarks compile:
   ```bash
   cargo check --all-targets
   ```

2. Run formatting:
   ```bash
   cargo fmt --all
   ```

3. Run clippy:
   ```bash
   cargo clippy --all-targets
   ```

4. Test that benchmarks run successfully:
   ```bash
   cargo bench -p benches -- --test
   ```

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` for new features/benchmarks
- `fix:` for bug fixes
- `perf:` for performance improvements
- `docs:` for documentation changes
- `chore:` for maintenance tasks

Examples:
- `feat(benches): add new streaming join benchmark`
- `fix(benches): correct reachability benchmark input data`
- `docs(benches): update README with new benchmark instructions`

## Pull Requests

When submitting a pull request:

1. Provide a clear title following Conventional Commits format
2. Describe what the PR adds or changes
3. Include benchmark results if relevant (before/after comparisons)
4. Reference any related issues or PRs in the main repository
5. Ensure all tests pass

## Questions?

For questions about:
- **Benchmarks**: Open an issue in this repository
- **Hydro/DFIR**: See the main [bigweaver-agent-canary-hydro-zeta](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository
- **Migration**: See [docs/docs/benchmarks/migration.md](https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/docs/docs/benchmarks/migration.md) in the main repository
