# Migration Documentation: Timely and Differential-Dataflow Benchmarks

## 📋 Overview

This document describes the migration of timely and differential-dataflow benchmarks from the `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## 🎯 Purpose

The migration was performed to:
- **Reduce dependency footprint**: Remove heavy dependencies from the main Hydro repository
- **Improve build times**: Allow the core Hydro library to build faster without unnecessary dependencies
- **Maintain clean architecture**: Separate performance comparison tools from core functionality
- **Preserve functionality**: Keep all benchmark capabilities intact in a dedicated location

## 🔧 What Was Moved

### Benchmarks
All benchmarks that depend on `timely` and `differential-dataflow` were moved:

1. **reachability.rs** - Graph reachability computation using differential-dataflow
2. **micro_ops.rs** - Basic dataflow operations (map, filter)
3. **fan_out.rs** - Fan-out dataflow patterns
4. **fan_in.rs** - Fan-in dataflow patterns
5. **arithmetic.rs** - Arithmetic operation chains

### Dependencies Removed from Main Repository
The following dependencies were removed from `bigweaver-agent-canary-hydro-zeta`:
- `timely` (0.12)
- `differential-dataflow` (0.12)

These dependencies are now only present in this repository.

## 📂 Repository Structure

### Before Migration

```
bigweaver-agent-canary-hydro-zeta/
├── benches/
│   ├── benches/
│   │   ├── reachability.rs
│   │   ├── micro_ops.rs
│   │   ├── fan_out.rs
│   │   ├── fan_in.rs
│   │   └── arithmetic.rs
│   ├── Cargo.toml (with timely/differential-dataflow deps)
│   └── README.md
├── Cargo.toml (workspace with benches member)
└── ... (other crates)
```

### After Migration

**bigweaver-agent-canary-hydro-zeta/**
```
bigweaver-agent-canary-hydro-zeta/
├── Cargo.toml (workspace WITHOUT benches member)
├── README.md (updated with reference to deps repo)
└── ... (other crates, no timely/differential-dataflow deps)
```

**bigweaver-agent-canary-zeta-hydro-deps/**
```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/
│   ├── benches/
│   │   ├── reachability.rs
│   │   ├── micro_ops.rs
│   │   ├── fan_out.rs
│   │   ├── fan_in.rs
│   │   └── arithmetic.rs
│   ├── Cargo.toml (with timely/differential-dataflow deps)
│   └── README.md
├── .github/
│   └── workflows/
│       └── bench.yml (CI for benchmarks)
├── Cargo.toml (workspace configuration)
├── README.md (comprehensive documentation)
└── MIGRATION.md (this file)
```

## ✅ Changes Made

### In bigweaver-agent-canary-hydro-zeta

1. ✅ Removed `benches/` directory and all its contents
2. ✅ Removed `benches` from workspace members in `Cargo.toml`
3. ✅ Updated `README.md` to reference the new deps repository
4. ✅ No longer requires `timely` or `differential-dataflow` dependencies

### In bigweaver-agent-canary-zeta-hydro-deps

1. ✅ Added `benches/` directory with all benchmark files
2. ✅ Created workspace `Cargo.toml` with proper configuration
3. ✅ Added comprehensive `README.md` documentation
4. ✅ Created `.gitignore` for Rust projects
5. ✅ Added CI workflow (`.github/workflows/bench.yml`) for automated testing
6. ✅ Created this `MIGRATION.md` documentation

## 🚀 Running Benchmarks

### In the New Repository

```bash
# Clone the deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cd benches
cargo bench

# Run a specific benchmark
cargo bench reachability
```

### Performance Comparison Workflow

To compare Hydro's performance with timely/differential-dataflow:

1. Run benchmarks in this repository (deps)
2. Run equivalent Hydro benchmarks in the main repository
3. Compare results

## 🔗 Cross-Repository References

### From Main Repository to Deps
The main repository's README now includes:
```markdown
# Related Repositories

- **[bigweaver-agent-canary-zeta-hydro-deps]**: Performance benchmarks and code 
  that depend on external dataflow libraries (timely, differential-dataflow). 
  Maintained separately to keep this repository lean and improve build times.
```

### From Deps to Main Repository
This repository's README references the main repository for core functionality.

## 💡 Benefits

1. **Faster Main Repository Builds**: No longer need to compile timely/differential-dataflow
2. **Cleaner Dependencies**: Main repository has minimal external dependencies
3. **Maintained Functionality**: All benchmarks work exactly as before
4. **Better Organization**: Clear separation of concerns
5. **Easier Maintenance**: Benchmarks can be updated independently

## 📝 Verification Steps

To verify the migration was successful:

1. **Check main repository builds without timely/differential-dataflow**:
   ```bash
   cd bigweaver-agent-canary-hydro-zeta
   cargo build
   # Should succeed without pulling in timely/differential-dataflow
   ```

2. **Check benchmarks build in deps repository**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo build
   # Should succeed with timely/differential-dataflow
   ```

3. **Run benchmarks**:
   ```bash
   cd bigweaver-agent-canary-zeta-hydro-deps/benches
   cargo bench
   # All benchmarks should run successfully
   ```

## 🔄 Future Additions

When adding new benchmarks that require timely or differential-dataflow:

1. Add the benchmark to `bigweaver-agent-canary-zeta-hydro-deps/benches/benches/`
2. Update the benchmark list in `benches/Cargo.toml` if needed
3. Update documentation in this repository's README
4. Do NOT add these dependencies to the main repository

## 📅 Migration Date

Migration completed: December 4, 2025

## 👥 Team Coordination

This migration follows the team's established pattern of:
- Separating dependencies into dedicated repositories
- Maintaining clean architectural boundaries
- Preserving performance comparison capabilities
- Reducing technical debt in the main codebase
