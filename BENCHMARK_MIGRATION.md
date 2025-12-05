# Benchmark Migration Guide

This document explains the migration of timely and differential-dataflow benchmarks from 
the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated 
`bigweaver-agent-canary-zeta-hydro-deps` repository.

## What Was Moved

All timely and differential-dataflow benchmarks have been moved to this repository, including:

- **Benchmark Files**: All `.rs` benchmark files from `benches/benches/`
- **Data Files**: Graph data and word lists used by benchmarks
- **Build Configuration**: `benches/Cargo.toml` and `benches/build.rs`
- **Documentation**: Benchmark README and usage instructions

## Why the Migration

The benchmarks were moved to achieve several goals:

1. **Reduced Dependencies**: Remove timely and differential-dataflow from the main repository
2. **Faster Build Times**: Main repository builds faster without benchmark dependencies
3. **Separation of Concerns**: Benchmarking is separate from core functionality
4. **Independent Testing**: Benchmarks can be run and maintained independently
5. **Performance Comparison**: Still possible to compare performance across versions

## Running Benchmarks

### In This Repository

Clone this repository and run benchmarks directly:

```bash
git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench -p benches
```

Run specific benchmarks:

```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench identity
```

### Performance Comparison with Main Repository

To compare performance between versions:

1. Run benchmarks in this repository to establish a baseline
2. Criterion saves baseline results in `target/criterion/`
3. Make changes in the main repository
4. Update git dependencies in this repository's `benches/Cargo.toml`
5. Run benchmarks again to see performance differences

Criterion will automatically compare results and show performance changes.

## Dependencies

The benchmarks now use git dependencies to reference the main repository:

```toml
[dev-dependencies]
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git" }
```

This allows:
- Independent benchmark execution without local checkout of main repository
- Easy version pinning by specifying git branch, tag, or commit
- Maintained compatibility with the main repository

## Updating Dependencies

To benchmark against a specific version of the main repository:

```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "abc123", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", rev = "abc123" }
```

Or use a branch:

```toml
dfir_rs = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main" }
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operations performance |
| `fan_in` | Fan-in dataflow pattern |
| `fan_out` | Fan-out dataflow pattern |
| `fork_join` | Fork-join pattern with filtering |
| `futures` | Futures-based async operations |
| `identity` | Identity transformation baseline |
| `join` | Join operation performance |
| `micro_ops` | Fine-grained micro-operations |
| `reachability` | Graph reachability algorithms |
| `symmetric_hash_join` | Symmetric hash join operations |
| `upcase` | String transformation operations |
| `words_diamond` | Diamond pattern with word processing |

## Continuous Integration

Benchmarks can be run in CI by adding them to your workflow:

```yaml
- name: Run benchmarks
  run: cargo bench -p benches --no-fail-fast
```

For performance regression testing, you can use Criterion's `--save-baseline` and 
`--baseline` options to compare against previous runs.

## Questions or Issues

If you encounter issues with the benchmarks or have questions about the migration, 
please open an issue in this repository.
