# Benchmark Migration Guide

This document explains how the benchmarks were migrated from the main `bigweaver-agent-canary-hydro-zeta` repository to this dedicated `bigweaver-agent-canary-zeta-hydro-deps` repository.

## 📋 What Was Moved

### Microbenchmarks (from `benches/` directory)
All Criterion-based microbenchmarks that depend on `timely` and `differential-dataflow`:

- **Source**: `benches/` directory in main repository
- **Destination**: `benches/` directory in this repository
- **Files moved**:
  - `benches/Cargo.toml` - Package configuration
  - `benches/build.rs` - Build script
  - `benches/README.md` - Benchmark documentation
  - `benches/benches/*.rs` - 13 benchmark suites
  - `benches/benches/*.txt` - Test data files

### Distributed Protocol Benchmarks (from `hydro_test/` directory)
Benchmark modules and examples for Paxos and Two-Phase Commit:

- **Source**: `hydro_test/src/cluster/` and `hydro_test/examples/`
- **Destination**: `hydro_test_benchmarks/` in this repository
- **Modules moved**:
  - `paxos_bench.rs` - Paxos benchmark implementation
  - `two_pc_bench.rs` - Two-Phase Commit benchmark
  - `kv_replica.rs` - Key-value replica support module
  - `paxos_with_client.rs` - Paxos client interface
  - `paxos.rs` - Paxos protocol implementation
  - `two_pc.rs` - Two-Phase Commit protocol
  - `compartmentalized_paxos.rs` - Compartmentalized Paxos variant
- **Examples moved**:
  - `paxos.rs` - Paxos benchmark example
  - `two_pc.rs` - Two-Phase Commit example
  - `compartmentalized_paxos.rs` - Compartmentalized Paxos example

## 🎯 Why This Migration Was Done

1. **Dependency Isolation**: Remove `timely` and `differential-dataflow` dependencies from the main repository
2. **Build Time Optimization**: Reduce compilation time for developers working on core Hydro features
3. **Cleaner Architecture**: Separate performance benchmarking concerns from core development
4. **Maintained Functionality**: Preserve all benchmark capabilities in a dedicated repository

## 🔧 Changes Made to Dependencies

### Before (in main repository):
```toml
# benches/Cargo.toml
dfir_rs = { path = "../dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../sinktools", version = "^0.0.1" }
```

### After (in this repository):
```toml
# benches/Cargo.toml
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta" }
```

All path-based dependencies to the main Hydro crates were converted to git dependencies.

## 📦 Repository Structure Created

```
bigweaver-agent-canary-zeta-hydro-deps/
├── Cargo.toml                      # Workspace configuration
├── rust-toolchain.toml             # Rust version specification
├── .gitignore                      # Git ignore rules
├── README.md                       # Comprehensive documentation
├── MIGRATION.md                    # This file
├── benches/                        # Microbenchmarks package
│   ├── Cargo.toml
│   ├── build.rs
│   ├── README.md
│   └── benches/                    # Benchmark implementations
│       ├── arithmetic.rs
│       ├── fan_in.rs
│       ├── fan_out.rs
│       ├── fork_join.rs
│       ├── futures.rs
│       ├── identity.rs
│       ├── join.rs
│       ├── micro_ops.rs
│       ├── reachability.rs
│       ├── symmetric_hash_join.rs
│       ├── upcase.rs
│       └── words_diamond.rs
└── hydro_test_benchmarks/          # Distributed protocol benchmarks
    ├── Cargo.toml
    ├── build.rs
    ├── src/
    │   ├── lib.rs
    │   ├── compartmentalized_paxos.rs
    │   ├── kv_replica.rs
    │   ├── paxos.rs
    │   ├── paxos_bench.rs
    │   ├── paxos_with_client.rs
    │   ├── two_pc.rs
    │   └── two_pc_bench.rs
    └── examples/
        ├── compartmentalized_paxos.rs
        ├── paxos.rs
        └── two_pc.rs
```

## ✅ Post-Migration Tasks

### In Main Repository (`bigweaver-agent-canary-hydro-zeta`)
The following should be done in the main repository:

1. **Remove benchmark files**:
   - Delete `benches/` directory
   - Delete `hydro_test/src/cluster/paxos_bench.rs`
   - Delete `hydro_test/src/cluster/two_pc_bench.rs`
   - Delete `hydro_test/examples/paxos.rs`
   - Delete `hydro_test/examples/two_pc.rs`
   - Delete `hydro_test/examples/compartmentalized_paxos.rs`

2. **Update workspace configuration**:
   - Remove `"benches"` from workspace members in root `Cargo.toml`

3. **Update module exports**:
   - Update `hydro_test/src/cluster/mod.rs` to remove:
     ```rust
     pub mod paxos_bench;
     pub mod two_pc_bench;
     ```

4. **Update documentation**:
   - Add reference to this repository in main README.md
   - Update CONTRIBUTING.md to mention benchmark repository
   - Optionally create BENCHMARKS_MIGRATION.md guide

### In This Repository
Already completed:
- ✅ Created workspace structure
- ✅ Moved all benchmark files
- ✅ Updated Cargo.toml files with git dependencies
- ✅ Created comprehensive README.md
- ✅ Created build scripts
- ✅ Set up proper module structure
- ✅ Added rust-toolchain.toml for consistency
- ✅ Created .gitignore

## 🚀 How to Use After Migration

### For Developers Running Benchmarks:

1. Clone this repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Run benchmarks:
   ```bash
   # Microbenchmarks
   cargo bench -p benches
   
   # Specific benchmark
   cargo bench -p benches --bench reachability
   
   # Protocol benchmarks
   cargo run --example paxos --package hydro_test_benchmarks
   ```

### For Developers Working on Main Hydro Code:

- No changes needed! The `timely` and `differential-dataflow` dependencies are now isolated
- Build times for the main repository should be significantly reduced
- To run benchmarks, clone this repository separately

## 🔄 Keeping Dependencies in Sync

The benchmarks in this repository reference the main Hydro repository via git dependencies. To update to the latest version:

```bash
cargo update
```

Or to test against a specific branch:

```toml
[dependencies]
hydro_lang = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta", branch = "feature-branch" }
```

## 📝 Notes

- All benchmark functionality has been preserved
- No changes to benchmark behavior or API
- Git dependencies will automatically use the latest version from the main branch
- Benchmark results remain comparable to historical data
- The separation is transparent to benchmark users

## 🤝 Contributing

When contributing benchmarks:
1. Add new benchmarks to this repository
2. Update the README.md with new benchmark descriptions
3. Ensure all benchmarks compile and run successfully
4. Consider adding comparison baselines for new benchmarks
