# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were extracted from the 
`bigweaver-agent-canary-hydro-zeta` repository to maintain separation of concerns
and reduce dependencies in the main codebase.

## Contents

### Timely-Benchmarks

Performance benchmarks for timely-dataflow and differential-dataflow libraries.

**Location**: `timely-benchmarks/`

These benchmarks test various dataflow patterns and compare performance against 
baseline Rust implementations:

- **Arithmetic** - Pipeline of arithmetic operations
- **Fan In** - Merging multiple streams
- **Fan Out** - Splitting streams
- **Fork Join** - Alternating split/merge operations
- **Identity** - Pass-through operations
- **Join** - Stream joins on keys
- **Reachability** - Graph reachability with fixed-point iteration
- **Upcase** - String transformations

See [`timely-benchmarks/README.md`](timely-benchmarks/README.md) for detailed documentation.

## Quick Start

### Running Benchmarks

```bash
# Run all benchmarks
cargo bench --workspace

# Run timely benchmarks only
cargo bench -p timely-benchmarks

# Run a specific benchmark
cargo bench -p timely-benchmarks --bench reachability

# Run benchmarks matching a pattern
cargo bench -p timely-benchmarks -- differential
```

## Migration History

### 2024-11-25: Timely and Differential-Dataflow Benchmarks

**From**: `bigweaver-agent-canary-hydro-zeta/benches/`  
**To**: `bigweaver-agent-canary-zeta-hydro-deps/timely-benchmarks/`

**Migrated benchmarks**:
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- identity.rs
- join.rs
- reachability.rs
- upcase.rs

**Migrated data files**:
- reachability_edges.txt
- reachability_reachable.txt
- words_alpha.txt
- build.rs

**Changes**: Removed dfir_rs (Hydroflow) specific benchmarks to eliminate 
dependencies on the main repository. Retained all timely and differential-dataflow
benchmarks with full functionality.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                    # Workspace configuration
├── README.md                     # This file
└── timely-benchmarks/            # Timely/differential benchmarks
    ├── Cargo.toml               # Benchmark package configuration
    ├── README.md                # Detailed benchmark documentation
    ├── build.rs                 # Build script
    └── benches/                 # Benchmark source files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── upcase.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── words_alpha.txt
```

## Purpose

This repository serves to:

1. **Reduce main repository dependencies**: Keep timely/differential-dataflow 
   dependencies separate from the main codebase
2. **Maintain performance visibility**: Enable continued performance testing 
   and comparison
3. **Enable independent evolution**: Allow benchmark updates without affecting 
   main repository
4. **Preserve historical data**: Maintain performance comparison capabilities

## Development

### Adding New Benchmarks

1. Add benchmark file to `timely-benchmarks/benches/`
2. Update `timely-benchmarks/Cargo.toml` to include the new benchmark
3. Update `timely-benchmarks/README.md` with benchmark description
4. Ensure dependencies are properly declared

### Updating Benchmarks

When updating benchmarks:
- Maintain backward compatibility where possible
- Document breaking changes in commit messages
- Update relevant README sections
- Run full benchmark suite to verify changes

## Related Repositories

- **bigweaver-agent-canary-hydro-zeta**: Main repository (source of these benchmarks)

## License

Apache-2.0