# Hydro Performance Benchmarks

This repository contains performance benchmarks comparing DFIR/Hydroflow with timely-dataflow and differential-dataflow frameworks.

## Overview

These benchmarks were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:
- Reduce dependency footprint in the main repository
- Maintain independent performance testing capabilities
- Allow for separate versioning and development of benchmarks
- Enable optional performance comparison (clone only when needed)

## Benchmarks Included

The repository includes the following benchmark suites:

1. **arithmetic.rs** - Arithmetic operation benchmarks
2. **fan_in.rs** - Fan-in pattern benchmarks
3. **fan_out.rs** - Fan-out pattern benchmarks
4. **fork_join.rs** - Fork-join pattern benchmarks
5. **futures.rs** - Futures-based benchmarks
6. **identity.rs** - Identity operation benchmarks
7. **join.rs** - Join operation benchmarks
8. **micro_ops.rs** - Micro-operation benchmarks
9. **reachability.rs** - Graph reachability benchmarks
10. **symmetric_hash_join.rs** - Symmetric hash join benchmarks
11. **upcase.rs** - String uppercase benchmarks
12. **words_diamond.rs** - Word processing diamond pattern benchmarks

## Dependencies

The benchmarks compare three frameworks:
- **DFIR/Hydroflow** - The Dataflow Intermediate Representation framework
- **timely-dataflow** - Low-latency data-parallel dataflow system
- **differential-dataflow** - Differential dataflow over timely dataflow

## Setup

### Prerequisites

- Rust toolchain (latest stable or as specified in rust-toolchain.toml if present)
- Cargo

### Configuration Options

The `Cargo.toml` supports three dependency configuration modes:

#### Option 1: Git Dependencies (Default - Recommended for standalone usage)
```toml
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/hydro-project/hydro", branch = "main" }
```

#### Option 2: Local Path Dependencies (For development alongside main repo)
```toml
dfir_rs = { path = "../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../bigweaver-agent-canary-hydro-zeta/sinktools" }
```

#### Option 3: Published Crate Dependencies (If using published versions)
```toml
dfir_rs = { version = "0.14.0", features = [ "debugging" ] }
sinktools = { version = "0.0.1" }
```

### Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Verify dependencies resolve
cargo check

# Build benchmarks
cargo build --release
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark

```bash
# Run the arithmetic benchmark
cargo bench --bench arithmetic

# Run the reachability benchmark
cargo bench --bench reachability

# Run the join benchmark
cargo bench --bench join
```

### Benchmark Output

Benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework, which provides:
- Statistical analysis of performance
- HTML reports with graphs
- Comparison with previous runs
- Detection of performance regressions

Results are saved to `target/criterion/` directory and include:
- Detailed timing statistics
- Performance graphs
- Historical comparisons

## Test Data

The repository includes test data files for benchmarks:
- `benches/reachability_edges.txt` - Graph edges for reachability benchmarks (533KB)
- `benches/reachability_reachable.txt` - Reachability test data (38KB)
- `benches/words_alpha.txt` - Word list for string processing benchmarks (3.7MB)

Source: Word list from [dwyl/english-words](https://github.com/dwyl/english-words/blob/master/words_alpha.txt)

## Performance Comparison

These benchmarks enable direct performance comparison between:
- **DFIR/Hydroflow** - Native implementation
- **Timely Dataflow** - Established streaming dataflow system
- **Differential Dataflow** - Incremental computation framework

### Example Benchmark Patterns

Each benchmark typically includes implementations for multiple frameworks:

```rust
// DFIR/Hydroflow implementation
fn benchmark_dfir(c: &mut Criterion) { ... }

// Timely Dataflow implementation
fn benchmark_timely(c: &mut Criterion) { ... }

// Differential Dataflow implementation
fn benchmark_differential(c: &mut Criterion) { ... }
```

## Contributing

When adding new benchmarks:
1. Follow the existing benchmark structure
2. Include implementations for all three frameworks when applicable
3. Use consistent naming conventions
4. Document the benchmark purpose and expected behavior
5. Include any necessary test data files
6. Update this README with the new benchmark description

## Migration History

This code was migrated from the main bigweaver-agent-canary-hydro-zeta repository on 2024-11-21. For historical context, see the [REMOVAL_SUMMARY.md](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta/blob/main/REMOVAL_SUMMARY.md) in the main repository.

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main Hydro framework repository
- [hydro-project/hydro](https://github.com/hydro-project/hydro) - Upstream Hydro project

## Support

For issues related to:
- **Benchmark code**: Open an issue in this repository
- **DFIR/Hydroflow functionality**: Open an issue in the main bigweaver-agent-canary-hydro-zeta repository
- **Timely/Differential frameworks**: Refer to their respective repositories
