# Benchmark Migration Documentation

## Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this repository.

## Migration Details

### Source Commit
- **Repository**: bigweaver-agent-canary-hydro-zeta
- **Commit**: b161bc10ad3946dbdf16659d1bb9a7031ba1c909
- **Commit Message**: "chore(benches): remove timely/differential-dataflow dependencies and benchmarks"
- **Date**: Fri Nov 28 19:31:24 2025 +0000
- **Parent Commit**: 484e6fddffa97d507384773d51bf728770a6ac38

### Files Migrated

#### Benchmark Files
All files from the `benches/` directory:
- `benches/Cargo.toml` - Package configuration with all dependencies
- `benches/README.md` - Original benchmark documentation
- `benches/build.rs` - Build script for generating fork_join benchmark
- `benches/benches/.gitignore` - Git ignore rules for generated files
- `benches/benches/arithmetic.rs` - Arithmetic operations benchmark
- `benches/benches/fan_in.rs` - Fan-in pattern benchmark
- `benches/benches/fan_out.rs` - Fan-out pattern benchmark
- `benches/benches/fork_join.rs` - Fork-join pattern benchmark
- `benches/benches/futures.rs` - Async futures benchmark
- `benches/benches/identity.rs` - Identity operation benchmark
- `benches/benches/join.rs` - Join operation benchmark
- `benches/benches/micro_ops.rs` - Micro-operations benchmark
- `benches/benches/reachability.rs` - Graph reachability benchmark
- `benches/benches/reachability_edges.txt` - Test data for reachability
- `benches/benches/reachability_reachable.txt` - Expected results for reachability
- `benches/benches/symmetric_hash_join.rs` - Symmetric hash join benchmark
- `benches/benches/upcase.rs` - String case conversion benchmark
- `benches/benches/words_alpha.txt` - Word list data (370k+ words)
- `benches/benches/words_diamond.rs` - Word processing diamond pattern benchmark

#### CI/CD Workflow
- `.github/workflows/benchmark.yml` - GitHub Actions workflow for running benchmarks

#### Configuration Files
- `rust-toolchain.toml` - Rust toolchain specification
- `rustfmt.toml` - Rust formatting configuration
- `clippy.toml` - Clippy linting configuration
- `Cargo.toml` - Workspace configuration (created for this repository)

## Dependency Changes

The benchmark dependencies were updated to reference the main repository via Git:

### Before (Path Dependencies)
```toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

### After (Git Dependencies)
```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fddffa97d507384773d51bf728770a6ac38", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "484e6fddffa97d507384773d51bf728770a6ac38" }
```

This change allows the benchmarks to remain functional while being in a separate repository, by referencing the specific commit from the main repository.

## Rationale

The benchmarks were separated from the main repository to:
1. Avoid direct dependencies on `timely` and `differential-dataflow` in the main service repository
2. Maintain the ability to run performance comparisons
3. Keep the main repository focused on core functionality
4. Isolate benchmark-specific dependencies and workflows

## Running Benchmarks

### Prerequisites
- Rust toolchain (version specified in `rust-toolchain.toml`)
- Access to the main repository (for Git dependencies)

### Commands

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmark:
```bash
cargo bench -p benches --bench <benchmark_name>
```

Available benchmark names:
- arithmetic
- fan_in
- fan_out
- fork_join
- futures
- identity
- join
- micro_ops
- reachability
- symmetric_hash_join
- upcase
- words_diamond

### Running Specific Benchmark Categories

Run only dfir benchmarks:
```bash
cargo bench -p benches -- dfir
```

Run only micro-operations benchmarks:
```bash
cargo bench -p benches -- micro/ops/
```

## CI/CD Integration

The benchmark workflow (`.github/workflows/benchmark.yml`) runs automatically on:

1. **Push events**: On main and feature/** branches (when commit message contains `[ci-bench]`)
2. **Pull requests**: When PR title or body contains `[ci-bench]`
3. **Schedule**: Daily at 3:35 AM UTC
4. **Manual trigger**: Via workflow_dispatch with `should_bench: true`

The workflow:
- Checks out the code
- Checks out the gh-pages branch for historical data
- Runs the benchmarks
- Generates benchmark reports using criterion
- Publishes results to GitHub Pages (for main branch only)
- Creates benchmark artifacts for download

## Maintenance Notes

### Updating Dependencies

When the main repository's API changes, update the `rev` field in the Git dependencies to point to a newer commit:

```toml
dfir_rs = { git = "...", rev = "<new_commit_hash>", features = [ "debugging" ] }
```

### Adding New Benchmarks

1. Create a new `.rs` file in `benches/benches/`
2. Add a corresponding `[[bench]]` section in `benches/Cargo.toml`
3. Update the README.md with the new benchmark description
4. Test locally before committing

### Troubleshooting

If benchmarks fail to compile:
1. Check that the Git dependency revision is valid
2. Ensure the main repository commit has the required features
3. Verify that the Rust toolchain version matches requirements
4. Check for breaking changes in the main repository API

## Related Documentation

- Main Repository: bigweaver-agent-canary-hydro-zeta
- Original Commit: https://github.com/hydro-project/hydro (upstream reference)
- Criterion Documentation: https://bheisler.github.io/criterion.rs/book/
