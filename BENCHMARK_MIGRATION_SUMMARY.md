# Benchmark Migration Summary

## What Was Moved?

The following timely-dataflow and differential-dataflow benchmarks were migrated:

1. **arithmetic.rs** - Arithmetic operations benchmark
2. **fan_in.rs** - Fan-in pattern benchmark for data aggregation
3. **fan_out.rs** - Fan-out pattern benchmark for data distribution
4. **fork_join.rs** - Fork-join pattern benchmark
5. **identity.rs** - Identity operation benchmark (data pass-through)
6. **join.rs** - Join operation benchmark
7. **reachability.rs** - Graph reachability computation benchmark (with data files)
8. **upcase.rs** - String uppercase transformation benchmark
9. **zip.rs** - Zip operation benchmark

**Supporting files:**
- reachability_edges.txt (test data)
- reachability_reachable.txt (test data)

## From Where?

**Source Repository:** `bigweaver-agent-canary-hydro-zeta`
- Original location: `benches/benches/*.rs`
- All benchmark files and related dependencies have been removed from the source repository

## To Where?

**Destination Repository:** `bigweaver-agent-canary-zeta-hydro-deps`
- New location: `timely-differential-benches/benches/*.rs`
- New package created: `timely-differential-benches`
- Added to workspace in root `Cargo.toml`

## Why Was This Done?

The migration was performed to achieve several important goals:

### 1. **Reduce Dependency Bloat**
Remove timely-dataflow and differential-dataflow dependencies from the main repository, which are heavyweight libraries only needed for benchmarking.

### 2. **Improve Build Times**
The main repository no longer needs to compile timely and differential-dataflow, significantly reducing build times for regular development work.

### 3. **Maintain Performance Comparison Capability**
By keeping the benchmarks in a separate repository, we can still run performance comparisons between different dataflow implementations (timely, differential, babyflow, hydroflow, spinachflow) without polluting the main codebase.

### 4. **Simplify Development**
The main repository remains focused on core functionality while benchmarking infrastructure is maintained separately, making it easier for developers to work on either area independently.

### 5. **Better Organization**
Separating concerns allows each repository to have a clear purpose:
- **bigweaver-agent-canary-hydro-zeta**: Core dataflow implementations
- **bigweaver-agent-canary-zeta-hydro-deps**: Performance benchmarking with external dependencies

## How to Use the Migrated Benchmarks

### Run all benchmarks:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run a specific benchmark:
```bash
cargo bench -p timely-differential-benches --bench arithmetic
```

### Cross-repository performance comparison:
```bash
cd bigweaver-agent-canary-zeta-hydro-deps
./scripts/compare_benchmarks.sh
```

## Additional Documentation

For more detailed information, see:
- **MIGRATION.md** - Comprehensive migration documentation
- **README.md** - Repository overview and usage instructions
- **timely-differential-benches/README.md** - Benchmark-specific documentation
