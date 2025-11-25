# Documentation Index

## Getting Started

- **[README.md](./README.md)** - Repository overview, quick start, and structure
- **[QUICK_REFERENCE.md](./QUICK_REFERENCE.md)** - Common commands and quick reference guide

## Migration Information

- **[MIGRATION.md](./MIGRATION.md)** - Complete migration history and details
  - Why benchmarks were moved
  - What was migrated
  - How to use benchmarks after migration
  - Rollback procedures

- **[ORIGINAL_REPO_UPDATES.md](./ORIGINAL_REPO_UPDATES.md)** - Required updates for source repository
  - Files to remove
  - Configuration changes
  - Documentation updates

## Testing and Verification

- **[VERIFICATION_CHECKLIST.md](./VERIFICATION_CHECKLIST.md)** - Comprehensive testing checklist
  - Pre-migration verification
  - Post-migration testing
  - Completeness checks

## Benchmark Documentation

- **[timely-benchmarks/README.md](./timely-benchmarks/README.md)** - Detailed benchmark documentation
  - Individual benchmark descriptions
  - Running instructions
  - Performance comparison details

## Project Information

- **[CHANGELOG.md](./CHANGELOG.md)** - Version history and release notes
- **[MIGRATION_SUMMARY.md](./MIGRATION_SUMMARY.md)** - Complete migration summary

## Configuration Files

- **[Cargo.toml](./Cargo.toml)** - Workspace configuration
- **[timely-benchmarks/Cargo.toml](./timely-benchmarks/Cargo.toml)** - Benchmark package configuration
- **[.gitignore](./.gitignore)** - Git ignore rules

## Quick Links

### For Developers
→ Start here: [README.md](./README.md)  
→ Common commands: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)  
→ Running benchmarks: [timely-benchmarks/README.md](./timely-benchmarks/README.md)

### For Migration
→ Migration history: [MIGRATION.md](./MIGRATION.md)  
→ Testing checklist: [VERIFICATION_CHECKLIST.md](./VERIFICATION_CHECKLIST.md)  
→ Original repo updates: [ORIGINAL_REPO_UPDATES.md](./ORIGINAL_REPO_UPDATES.md)

### For Understanding
→ Why separated: [MIGRATION.md - Rationale](./MIGRATION.md#rationale)  
→ What changed: [MIGRATION.md - What Was Migrated](./MIGRATION.md#what-was-migrated)  
→ How to run: [QUICK_REFERENCE.md - Running Benchmarks](./QUICK_REFERENCE.md#running-benchmarks)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── README.md                     # Repository overview
├── INDEX.md                      # This file
├── MIGRATION.md                  # Migration documentation
├── QUICK_REFERENCE.md            # Command reference
├── VERIFICATION_CHECKLIST.md    # Testing checklist
├── ORIGINAL_REPO_UPDATES.md     # Source repo update guide
├── Cargo.toml                    # Workspace config
├── .gitignore                    # Git ignore rules
│
└── timely-benchmarks/           # Timely/Differential benchmarks
    ├── README.md                 # Benchmark documentation
    ├── Cargo.toml               # Package configuration
    ├── build.rs                 # Build script
    └── benches/                 # Benchmark files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── identity.rs
        ├── join.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        └── upcase.rs
```

## Benchmark Files

### Timely Dataflow Benchmarks
- [arithmetic.rs](./timely-benchmarks/benches/arithmetic.rs) - Arithmetic pipeline operations
- [fan_in.rs](./timely-benchmarks/benches/fan_in.rs) - Fan-in pattern
- [fan_out.rs](./timely-benchmarks/benches/fan_out.rs) - Fan-out pattern
- [fork_join.rs](./timely-benchmarks/benches/fork_join.rs) - Fork-join pattern
- [identity.rs](./timely-benchmarks/benches/identity.rs) - Identity transformations
- [join.rs](./timely-benchmarks/benches/join.rs) - Join operations
- [upcase.rs](./timely-benchmarks/benches/upcase.rs) - String transformations

### Differential Dataflow Benchmarks
- [reachability.rs](./timely-benchmarks/benches/reachability.rs) - Graph reachability computation

## External Resources

- [Main Hydro Repository](https://github.com/hydro-project/hydro)
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Criterion.rs Benchmarking](https://github.com/bheisler/criterion.rs)

## Document History

- 2024-11-25: Initial documentation created with benchmark migration
