# Complete File Manifest

This document lists all files in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Root Directory Files

| File | Size | Purpose |
|------|------|---------|
| COMPLETION_SUMMARY.md | 9.9K | |
| Cargo.toml | 2.8K | |
| FILE_MANIFEST.md | 192 | |
| FINAL_VERIFICATION_REPORT.md | 4.8K | |
| LICENSE | 12K | |
| MIGRATION_GUIDE.md | 8.9K | |
| QUICK_REFERENCE.md | 7.4K | |
| README.md | 5.8K | |
| clippy.toml | 74 | |
| rust-toolchain.toml | 235 | |
| rustfmt.toml | 297 | |
| verify.sh | 4.7K | |

### Root Files Description

- **Cargo.toml** - Workspace configuration with lints and profiles
- **LICENSE** - Apache 2.0 license file
- **README.md** - Main repository documentation
- **MIGRATION_GUIDE.md** - Detailed migration documentation
- **COMPLETION_SUMMARY.md** - Summary of migration work
- **QUICK_REFERENCE.md** - Quick command reference
- **FINAL_VERIFICATION_REPORT.md** - Verification report
- **FILE_MANIFEST.md** - This file
- **verify.sh** - Verification script
- **.gitignore** - Git ignore rules
- **rust-toolchain.toml** - Rust toolchain specification (1.91.1)
- **rustfmt.toml** - Code formatting configuration
- **clippy.toml** - Linting configuration

## Benchmark Package (benches/)

### Package Files

| File | Size | Purpose |
|------|------|---------|
| benches/Cargo.toml | 1.6K | |
| benches/README.md | 4.0K | |
| benches/build.rs | 1.1K | |

### Package Files Description

- **benches/Cargo.toml** - Benchmark dependencies configuration
- **benches/README.md** - Benchmark-specific documentation
- **benches/build.rs** - Build script for generated code

## Benchmark Implementations (benches/benches/)

### Benchmark Files (.rs)

| File | Size | Description |
|------|------|-------------|
| arithmetic.rs | 7.6K | |
| fan_in.rs | 3.5K | |
| fan_out.rs | 3.6K | |
| fork_join.rs | 4.3K | |
| futures.rs | 4.8K | |
| identity.rs | 6.8K | |
| join.rs | 4.4K | |
| micro_ops.rs | 12K | |
| reachability.rs | 14K | |
| symmetric_hash_join.rs | 4.5K | |
| upcase.rs | 3.1K | |
| words_diamond.rs | 7.0K | |

### Benchmark Descriptions

1. **arithmetic.rs** - Benchmarks for chains of arithmetic operations (map operations)
   - Implementations: Pipeline, Raw, Iterator, DFIR (surface/compiled), Timely

2. **fan_in.rs** - Multiple input streams converging to a single operator
   - Tests fan-in patterns with various framework implementations

3. **fan_out.rs** - Single input stream splitting to multiple operators
   - Tests fan-out patterns and data distribution

4. **fork_join.rs** - Parallel processing with fork and join patterns
   - Tests parallel branches and synchronization points

5. **futures.rs** - Async futures-based processing benchmarks
   - Tests async execution models across frameworks

6. **identity.rs** - Identity transformation (passthrough) benchmarks
   - Baseline performance without transformations

7. **join.rs** - Stream join operations
   - Tests different join strategies and implementations

8. **micro_ops.rs** - Micro-operations performance testing
   - Fine-grained operation benchmarks

9. **reachability.rs** - Graph reachability algorithms
   - Tests graph traversal and reachability computation

10. **symmetric_hash_join.rs** - Symmetric hash join operations
    - Tests symmetric hash join performance

11. **upcase.rs** - String transformation operations
    - Tests string processing and transformation

12. **words_diamond.rs** - Diamond-shaped dataflow patterns
    - Tests diamond patterns (fork then rejoin)

### Test Data Files

| File | Size | Description |
|------|------|-------------|
| reachability_edges.txt | 521K | |
| reachability_reachable.txt | 38K | |
| words_alpha.txt | 3.7M | |

### Test Data Descriptions

1. **words_alpha.txt** (~3.7MB)
   - English word list containing alphabetic words
   - Source: https://github.com/dwyl/english-words
   - Used by: words_diamond.rs, upcase.rs benchmarks

2. **reachability_edges.txt** (~524KB)
   - Graph edge list for reachability testing
   - Format: Edge pairs for graph algorithms
   - Used by: reachability.rs benchmark

3. **reachability_reachable.txt** (~40KB)
   - Expected reachable nodes for verification
   - Used to validate reachability algorithm results
   - Used by: reachability.rs benchmark

## Total Repository Statistics

- **Total Files**: 32
- **Benchmark Files**: 12
- **Test Data Files**: 3
- **Documentation Files**: 6
- **Configuration Files**: 6 (Cargo.toml x2, rust-toolchain.toml, rustfmt.toml, clippy.toml, .gitignore x2)
- **Total Repository Size**: 7.6M

## File Tree

.
|-- [ 104K]  .git
|   |-- [   21]  HEAD
|   |-- [ 4.0K]  branches
|   |-- [  363]  config
|   |-- [   73]  description
|   |-- [  29K]  hooks
|   |   |-- [  482]  applypatch-msg.sample
|   |   |-- [  900]  commit-msg.sample
|   |   |-- [ 4.6K]  fsmonitor-watchman.sample
|   |   |-- [  193]  post-update.sample
|   |   |-- [  428]  pre-applypatch.sample
|   |   |-- [ 1.6K]  pre-commit.sample
|   |   |-- [  420]  pre-merge-commit.sample
|   |   |-- [ 1.3K]  pre-push.sample
|   |   |-- [ 4.8K]  pre-rebase.sample
|   |   |-- [  548]  pre-receive.sample
|   |   |-- [ 1.5K]  prepare-commit-msg.sample
|   |   |-- [ 2.7K]  push-to-checkout.sample
|   |   |-- [ 2.3K]  sendemail-validate.sample
|   |   `-- [ 3.6K]  update.sample
|   |-- [  137]  index
|   |-- [  137]  index.agent-checkpoint.protoagent_pre-step-1763746509687-39b9306f-0b47-4f00-9ef6-cd2528636d1f.1_001
|   |-- [  137]  index.agent-checkpoint.protoagent_pre-step-1763747095054-97ef14fa-4e90-4ea4-ab9a-c55e8066afcc.1_001
|   |-- [  137]  index.agent-checkpoint.protoagent_pre-step-3054a90c-08f9-4655-aac1-3fed47d28e5e.1_001
|   |-- [  137]  index.agent-checkpoint.protoagent_pre-step-754ce176-d928-49b5-8ee7-0d20c70f8513.1_001
|   |-- [ 4.2K]  info
|   |   `-- [  240]  exclude
|   |-- [ 8.3K]  logs
|   |   |-- [  313]  HEAD
|   |   `-- [ 4.0K]  refs
|   |-- [  32K]  objects
|   |   |-- [ 4.0K]  17
|   |   |-- [ 4.0K]  19
|   |   |-- [ 4.0K]  21
|   |   |-- [ 4.0K]  96
|   |   |-- [ 4.0K]  99
|   |   |-- [ 4.0K]  info
|   |   `-- [ 4.0K]  pack
|   |-- [ 1.3K]  packed-refs
|   `-- [  20K]  refs
|       |-- [ 4.0K]  agent-checkpoint
|       |-- [ 4.0K]  heads
|       |-- [ 4.0K]  remotes
|       `-- [ 4.0K]  tags
|-- [  160]  .gitignore
|-- [ 9.8K]  COMPLETION_SUMMARY.md
|-- [ 2.7K]  Cargo.toml
|-- [ 4.5K]  FILE_MANIFEST.md
|-- [ 4.8K]  FINAL_VERIFICATION_REPORT.md
|-- [  11K]  LICENSE
|-- [ 8.9K]  MIGRATION_GUIDE.md
|-- [ 7.3K]  QUICK_REFERENCE.md
|-- [ 5.8K]  README.md
|-- [ 4.3M]  benches
|   |-- [ 1.6K]  Cargo.toml
|   |-- [ 4.0K]  README.md
|   |-- [ 4.3M]  benches
|   |   |-- [   15]  .gitignore
|   |   |-- [ 7.5K]  arithmetic.rs
|   |   |-- [ 3.4K]  fan_in.rs
|   |   |-- [ 3.5K]  fan_out.rs
|   |   |-- [ 4.2K]  fork_join.rs
|   |   |-- [ 4.8K]  futures.rs
|   |   |-- [ 6.7K]  identity.rs
|   |   |-- [ 4.4K]  join.rs
|   |   |-- [  12K]  micro_ops.rs
|   |   |-- [  13K]  reachability.rs
|   |   |-- [ 520K]  reachability_edges.txt
|   |   |-- [  38K]  reachability_reachable.txt
|   |   |-- [ 4.4K]  symmetric_hash_join.rs
|   |   |-- [ 3.1K]  upcase.rs
|   |   |-- [ 3.7M]  words_alpha.txt
|   |   `-- [ 7.0K]  words_diamond.rs
|   `-- [ 1.0K]  build.rs
|-- [   74]  clippy.toml
|-- [  235]  rust-toolchain.toml
|-- [  297]  rustfmt.toml
`-- [ 4.6K]  verify.sh

  4.5M used in 21 directories, 57 files

## Verification

All files listed above have been verified and are present in the repository.
Run `bash verify.sh` to perform a complete verification check.

## Notes

- All benchmark files (.rs) are located in `benches/benches/`
- All test data files (.txt) are located in `benches/benches/`
- Configuration files are at the root and in `benches/`
- Documentation files are at the root level
- Git metadata is in `.git/` directory (not listed above)

---

**Generated**: $(date)
**Repository**: bigweaver-agent-canary-zeta-hydro-deps
**Location**: /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
