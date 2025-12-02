# Repository Structure

This document provides an overview of the bigweaver-agent-canary-zeta-hydro-deps repository structure and file organization.

## Repository Layout

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                      # Main benchmarks package
│   ├── benches/                  # Benchmark implementations
│   │   ├── arithmetic.rs         # Arithmetic operation benchmarks
│   │   ├── fan_in.rs            # Fan-in pattern benchmarks
│   │   ├── fan_out.rs           # Fan-out pattern benchmarks
│   │   ├── fork_join.rs         # Fork-join pattern benchmarks
│   │   ├── futures.rs           # Async/futures benchmarks
│   │   ├── identity.rs          # Identity/baseline benchmarks
│   │   ├── join.rs              # Join operation benchmarks
│   │   ├── micro_ops.rs         # Micro-operation benchmarks
│   │   ├── reachability.rs      # Graph reachability benchmarks
│   │   ├── symmetric_hash_join.rs # Hash join benchmarks
│   │   ├── upcase.rs            # String transformation benchmarks
│   │   ├── words_diamond.rs     # Diamond pattern benchmarks
│   │   ├── reachability_edges.txt       # Graph data (532KB)
│   │   ├── reachability_reachable.txt   # Expected results (38KB)
│   │   └── words_alpha.txt              # Word list (3.8MB)
│   ├── build.rs                 # Build script (generates fork_join code)
│   ├── Cargo.toml              # Benches package configuration
│   └── README.md               # Benchmarks documentation
│
├── hydro_test_benches/         # Protocol benchmark references
│   ├── paxos_bench.rs          # Paxos benchmark reference
│   ├── two_pc_bench.rs         # Two-PC benchmark reference
│   └── README.md               # Protocol benchmarks documentation
│
├── hydro_test_examples/        # Runnable protocol examples
│   ├── src/                    # Source directory (may be empty)
│   ├── paxos.rs                # Paxos deployment example
│   ├── two_pc.rs               # Two-PC deployment example
│   ├── compartmentalized_paxos.rs # Compartmentalized Paxos example
│   ├── Cargo.toml             # Examples package configuration
│   └── README.md              # Examples documentation
│
├── .gitignore                  # Git ignore patterns
├── Cargo.toml                  # Workspace configuration
├── BENCHMARK_GUIDE.md          # Comprehensive benchmark guide
├── QUICK_START.md              # Quick start guide
├── README.md                   # Main repository documentation
├── REPOSITORY_STRUCTURE.md     # This file
└── SETUP_VERIFICATION.md       # Setup verification guide
```

## File Descriptions

### Root Level Documentation

| File | Purpose | When to Read |
|------|---------|--------------|
| **README.md** | Main entry point, overview | First time setup |
| **QUICK_START.md** | Get running in 5 minutes | Want to run benchmarks quickly |
| **BENCHMARK_GUIDE.md** | Comprehensive benchmark documentation | Need detailed benchmark information |
| **SETUP_VERIFICATION.md** | Verify setup, troubleshooting | Having setup issues |
| **REPOSITORY_STRUCTURE.md** | Repository organization | Understanding structure |

### Configuration Files

| File | Purpose |
|------|---------|
| **Cargo.toml** (root) | Workspace configuration, shared dependencies |
| **benches/Cargo.toml** | Benchmark package configuration |
| **hydro_test_examples/Cargo.toml** | Examples package configuration |
| **.gitignore** | Files to exclude from git |

### Package: benches

**Purpose**: Performance benchmarks comparing Hydro with timely/differential-dataflow.

**Key Files**:
- `benches/*.rs` - Individual benchmark implementations
- `build.rs` - Generates fork_join benchmark code at build time
- `benches/*.txt` - Data files for benchmarks
- `README.md` - Detailed benchmark documentation

**Dependencies**:
- timely-dataflow (timely-master 0.13.0-dev.1)
- differential-dataflow (differential-dataflow-master 0.13.0-dev.1)
- criterion (0.5.0) - Benchmark framework
- dfir_rs (from main repo) - Hydro dataflow runtime
- tokio (1.29.0) - Async runtime

**How to Use**:
```bash
cargo bench -p benches                    # Run all benchmarks
cargo bench -p benches --bench arithmetic # Run specific benchmark
```

### Package: hydro_test_examples

**Purpose**: Runnable examples of distributed protocols using Hydro.

**Key Files**:
- `paxos.rs` - Paxos consensus protocol example
- `two_pc.rs` - Two-Phase Commit protocol example
- `compartmentalized_paxos.rs` - Advanced Paxos implementation
- `README.md` - Examples documentation

**Dependencies**:
- hydro_lang (from main repo)
- hydro_deploy (from main repo)
- hydro_test (from main repo)
- clap (4.0.0) - CLI argument parsing
- tokio (1.29.0) - Async runtime

**How to Use**:
```bash
cargo run -p hydro_test_examples --example paxos
cargo run -p hydro_test_examples --example two_pc
```

### Directory: hydro_test_benches

**Purpose**: Reference implementations of protocol benchmarks.

**Key Files**:
- `paxos_bench.rs` - Paxos benchmark reference
- `two_pc_bench.rs` - Two-PC benchmark reference
- `README.md` - Documentation

**Note**: These are reference files showing how protocol benchmarks are structured. They're not compiled as part of this repository but serve as documentation and templates.

## Dependency Graph

```
bigweaver-agent-canary-zeta-hydro-deps (workspace)
├── benches (package)
│   ├── timely-dataflow (external)
│   ├── differential-dataflow (external)
│   ├── criterion (external)
│   ├── dfir_rs → ../bigweaver-agent-canary-hydro-zeta/dfir_rs
│   └── sinktools → ../bigweaver-agent-canary-hydro-zeta/sinktools
│
└── hydro_test_examples (package)
    ├── hydro_lang → ../bigweaver-agent-canary-hydro-zeta/hydro_lang
    ├── hydro_deploy → ../bigweaver-agent-canary-hydro-zeta/hydro_deploy/core
    ├── hydro_test → ../bigweaver-agent-canary-hydro-zeta/hydro_test
    └── clap (external)
```

## Build Artifacts

When you build the repository, these directories are created:

```
target/
├── debug/              # Debug builds
├── release/            # Release builds
└── criterion/          # Benchmark results
    └── <benchmark>/
        ├── report/     # HTML reports
        └── base/       # Baseline data
```

**Important**: The `target/` directory can be large (several GB). It's excluded by `.gitignore`.

## Data Files

The repository includes benchmark data files:

| File | Size | Purpose | Location |
|------|------|---------|----------|
| words_alpha.txt | 3.8 MB | English word list | benches/benches/ |
| reachability_edges.txt | 532 KB | Graph edges | benches/benches/ |
| reachability_reachable.txt | 38 KB | Expected results | benches/benches/ |

These are checked into git because they're needed for benchmarks.

## Generated Files

Some files are generated at build time:

| File | Generator | Purpose |
|------|-----------|---------|
| fork_join_20.hf | benches/build.rs | Fork-join benchmark code |

These are excluded by `.gitignore` via the pattern in `benches/benches/.gitignore`.

## Working with the Repository

### Common Operations

| Operation | Command |
|-----------|---------|
| Check everything compiles | `cargo check --workspace` |
| Build all packages | `cargo build --workspace` |
| Run all benchmarks | `cargo bench -p benches` |
| Run specific benchmark | `cargo bench -p benches --bench <name>` |
| Run example | `cargo run -p hydro_test_examples --example <name>` |
| Clean build artifacts | `cargo clean` |
| Update dependencies | `cargo update` |

### File Navigation

To find specific content:

| Looking for | Check |
|-------------|-------|
| Getting started | QUICK_START.md |
| Benchmark details | BENCHMARK_GUIDE.md |
| Setup help | SETUP_VERIFICATION.md |
| Benchmark code | benches/benches/*.rs |
| Example code | hydro_test_examples/*.rs |
| Dependencies | Cargo.toml files |

## Integration with Main Repository

This repository requires the main repository as a sibling:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/      # Main repository
└── bigweaver-agent-canary-zeta-hydro-deps/ # This repository
```

Path dependencies in Cargo.toml files reference `../../bigweaver-agent-canary-hydro-zeta/`.

## Size Information

Approximate sizes (excluding target/ directory):

- **Total repository**: ~9 MB
- **Benchmark data files**: ~4.4 MB
- **Source code**: ~4.5 MB
- **Documentation**: ~50 KB

With built artifacts (target/ directory): Can reach several GB.

## Maintenance Notes

### When Adding New Benchmarks

1. Add `.rs` file to `benches/benches/`
2. Add `[[bench]]` entry to `benches/Cargo.toml`
3. Update `benches/README.md` documentation
4. Update main `README.md` if significant

### When Adding New Examples

1. Add `.rs` file to `hydro_test_examples/`
2. Add `[[example]]` entry to `hydro_test_examples/Cargo.toml`
3. Update `hydro_test_examples/README.md` documentation

### When Updating Dependencies

1. Update version in root `Cargo.toml` `[workspace.dependencies]`
2. No need to update individual package Cargo.toml files (they use workspace deps)
3. Run `cargo update` to update Cargo.lock
4. Test all benchmarks and examples

## Navigation Tips

- **Start here**: README.md
- **Quick run**: QUICK_START.md
- **Having issues**: SETUP_VERIFICATION.md
- **Need details**: BENCHMARK_GUIDE.md
- **Understanding structure**: REPOSITORY_STRUCTURE.md (this file)
- **Find benchmark**: benches/README.md
- **Find example**: hydro_test_examples/README.md

## Related Documentation

- Main repository: `../bigweaver-agent-canary-hydro-zeta/README.md`
- Contributing: `../bigweaver-agent-canary-hydro-zeta/CONTRIBUTING.md`
- Hydro documentation: Main repository's `docs/` directory
