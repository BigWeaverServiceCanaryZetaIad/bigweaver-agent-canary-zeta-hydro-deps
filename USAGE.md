# Quick Reference: Using the Refactored Benchmarks

## Repository Locations

- **Main Hydro Repository**: `/projects/sandbox/bigweaver-agent-canary-hydro-zeta`
- **Hydro Dependencies Repository**: `/projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps`

## Running Benchmarks

### DFIR/Hydro Benchmarks (Main Repository)

```bash
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta

# Run all DFIR benchmarks
cargo bench -p benches

# Run specific DFIR benchmarks
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench symmetric_hash_join
cargo bench -p benches --bench words_diamond
cargo bench -p benches --bench futures
```

### Timely/Differential Comparison Benchmarks (Hydro-Deps Repository)

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps

# Run all comparison benchmarks
cargo bench -p hydro-deps-benches

# Run specific comparison benchmarks
cargo bench -p hydro-deps-benches --bench reachability
cargo bench -p hydro-deps-benches --bench join
cargo bench -p hydro-deps-benches --bench arithmetic
cargo bench -p hydro-deps-benches --bench fan_in
cargo bench -p hydro-deps-benches --bench fan_out
cargo bench -p hydro-deps-benches --bench fork_join
cargo bench -p hydro-deps-benches --bench identity
cargo bench -p hydro-deps-benches --bench upcase
```

## What's in Each Repository?

### Main Hydro Repository (bigweaver-agent-canary-hydro-zeta)
**Focus**: DFIR/Hydro-only benchmarks without external framework dependencies

**Benchmarks**:
- `micro_ops.rs` - Microbenchmarks for DFIR operations (map, filter, unique, etc.)
- `symmetric_hash_join.rs` - Symmetric hash join implementation
- `words_diamond.rs` - Diamond-pattern word processing
- `futures.rs` - Async futures integration

**Dependencies**: Only DFIR/Hydro stack (dfir_rs, sinktools)

### Hydro-Deps Repository (bigweaver-agent-canary-zeta-hydro-deps)
**Focus**: Performance comparisons against Timely Dataflow and Differential Dataflow

**Benchmarks**:
- `arithmetic.rs` - Arithmetic operations comparison
- `fan_in.rs` - Fan-in pattern comparison
- `fan_out.rs` - Fan-out pattern comparison
- `fork_join.rs` - Fork-join pattern comparison
- `identity.rs` - Identity transformation comparison
- `join.rs` - Join operations comparison (usize and String)
- `reachability.rs` - Graph reachability algorithm comparison
- `upcase.rs` - String transformation comparison

**Dependencies**: DFIR/Hydro (via git), Timely Dataflow, Differential Dataflow

## Documentation

### Main Repository
- `benches/README.md` - Benchmark documentation
- `benches/MIGRATION.md` - Details about the benchmark separation
- `CONTRIBUTING.md` - General contribution guidelines

### Hydro-Deps Repository
- `README.md` - Repository overview and usage
- `benches/README.md` - Benchmark details
- `CONTRIBUTING.md` - Contribution guidelines for dependency benchmarks

## Git Status

Both repositories have been committed with the refactoring changes:

```bash
# View hydro-zeta changes
cd /projects/sandbox/bigweaver-agent-canary-hydro-zeta
git log -1

# View hydro-deps changes
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
git log -1
```

## Key Benefits

1. **Reduced Dependencies**: Main Hydro repo no longer depends on Timely/Differential
2. **Isolation**: External framework dependencies are isolated in hydro-deps
3. **Maintained Functionality**: All performance comparison capabilities preserved
4. **Clear Separation**: DFIR-focused vs framework-comparison benchmarks
5. **Simplified Maintenance**: Users who only need DFIR don't pull unnecessary deps
