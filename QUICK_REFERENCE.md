# Quick Reference Guide

Quick commands and references for working with the benchmark repository.

## Setup

### Install Rust (if not already installed)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### Verify Installation
```bash
rustc --version
cargo --version
```

## Common Commands

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench arithmetic
cargo bench --bench reachability
cargo bench --bench join
```

### Run Specific Test Within Benchmark
```bash
# Run only DFIR tests
cargo bench --bench arithmetic -- dfir_rs

# Run only Timely tests
cargo bench --bench arithmetic -- timely

# Run only a specific test
cargo bench --bench arithmetic -- arithmetic/dfir_rs/compiled
```

### Build Only (No Execution)
```bash
cargo check
cargo build
cargo build --release
```

### View Available Benchmarks
```bash
ls benches/benches/*.rs
```

## Benchmark Results

### Location
```
target/criterion/
├── report/
│   └── index.html          # Main report page
├── arithmetic/
│   └── report/
│       └── index.html      # Arithmetic benchmark report
└── [other benchmarks]/
```

### View Results
```bash
# Open main report
open target/criterion/report/index.html

# Or for Linux
xdg-open target/criterion/report/index.html

# Or manually navigate to
ls -la target/criterion/*/report/index.html
```

## Available Benchmarks

| Name | Command | Description |
|------|---------|-------------|
| arithmetic | `cargo bench --bench arithmetic` | Arithmetic operations chain |
| fan_in | `cargo bench --bench fan_in` | Multiple inputs to one operator |
| fan_out | `cargo bench --bench fan_out` | One input to multiple operators |
| fork_join | `cargo bench --bench fork_join` | Fork and join patterns |
| futures | `cargo bench --bench futures` | Async futures processing |
| identity | `cargo bench --bench identity` | Passthrough/identity transform |
| join | `cargo bench --bench join` | Stream join operations |
| micro_ops | `cargo bench --bench micro_ops` | Micro-operations performance |
| reachability | `cargo bench --bench reachability` | Graph reachability |
| symmetric_hash_join | `cargo bench --bench symmetric_hash_join` | Symmetric hash join |
| upcase | `cargo bench --bench upcase` | String transformations |
| words_diamond | `cargo bench --bench words_diamond` | Diamond dataflow pattern |

## Framework Comparison

Each benchmark typically includes:

- **Raw/Baseline**: Pure Rust implementation
- **DFIR (surface)**: Hydroflow surface syntax
- **DFIR (compiled)**: Hydroflow compiled
- **Timely**: Timely Dataflow implementation
- **Differential**: Differential Dataflow implementation

### Compare Frameworks
```bash
# Run all implementations for a benchmark
cargo bench --bench arithmetic

# Run only DFIR implementations
cargo bench --bench arithmetic -- dfir_rs

# Run only Timely implementations
cargo bench --bench arithmetic -- timely

# Compare specific tests
cargo bench --bench arithmetic -- "arithmetic/(dfir_rs|timely)"
```

## Troubleshooting

### Cargo.lock Issues
```bash
rm -rf Cargo.lock
cargo update
```

### Clean Build
```bash
cargo clean
cargo build
```

### Dependency Issues
```bash
# Update dependencies
cargo update

# Check for issues
cargo check --verbose
```

### Git Dependency Issues
```bash
# Clear cargo cache
rm -rf ~/.cargo/git
rm -rf ~/.cargo/registry

# Retry build
cargo build
```

## Maintenance

### Update Hydro Dependencies
Edit `benches/Cargo.toml`:
```toml
# Use specific commit
dfir_rs = { git = "https://github.com/hydro-project/hydro", rev = "abc123", features = [ "debugging" ] }

# Use specific branch
dfir_rs = { git = "https://github.com/hydro-project/hydro", branch = "main", features = [ "debugging" ] }

# Use tag
dfir_rs = { git = "https://github.com/hydro-project/hydro", tag = "v0.1.0", features = [ "debugging" ] }
```

### Add New Benchmark

1. Create file: `benches/benches/my_benchmark.rs`
2. Add to `benches/Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Test: `cargo bench --bench my_benchmark`

### Format Code
```bash
cargo fmt
```

### Run Linter
```bash
cargo clippy
```

## Verification

### Check Structure
```bash
bash verify.sh
```

### List All Files
```bash
tree -L 3 -h
# or
find . -type f | grep -v ".git" | sort
```

### Check Sizes
```bash
du -sh .
du -sh benches/
du -h benches/benches/*.txt
```

## Performance Tips

### Faster Benchmarks (Less Accurate)
```bash
# Run with fewer iterations
cargo bench -- --sample-size 10
```

### Profile Mode
```bash
# Build with profiling info
cargo build --profile=profile
```

### Release Build
```bash
cargo build --release
```

## CI/CD Integration

### GitHub Actions Example
```yaml
- name: Run Benchmarks
  run: cargo bench --no-fail-fast

- name: Upload Results
  uses: actions/upload-artifact@v3
  with:
    name: benchmarks
    path: target/criterion/
```

### GitLab CI Example
```yaml
benchmarks:
  script:
    - cargo bench --no-fail-fast
  artifacts:
    paths:
      - target/criterion/
```

## Resources

### Documentation
- Main README: `README.md`
- Migration Guide: `MIGRATION_GUIDE.md`
- Benchmark Details: `benches/README.md`
- Completion Summary: `COMPLETION_SUMMARY.md`

### External Links
- Criterion.rs: https://bheisler.github.io/criterion.rs/
- Hydro Project: https://github.com/hydro-project/hydro
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

### Support
- Benchmark issues: Open issue in this repository
- DFIR/Hydroflow issues: https://github.com/hydro-project/hydro/issues
- Timely issues: https://github.com/TimelyDataflow/timely-dataflow/issues

## Cheat Sheet

```bash
# Quick verification
bash verify.sh

# Quick benchmark
cargo bench --bench arithmetic

# All benchmarks
cargo bench

# View results
open target/criterion/report/index.html

# Clean and rebuild
cargo clean && cargo build

# Update dependencies
cargo update

# Check without building
cargo check

# Format code
cargo fmt

# Lint code
cargo clippy
```

## File Locations

```
Repository Root
├── Cargo.toml                  # Workspace config
├── README.md                   # Main documentation
├── MIGRATION_GUIDE.md          # Migration details
├── COMPLETION_SUMMARY.md       # What was done
├── QUICK_REFERENCE.md          # This file
├── verify.sh                   # Verification script
├── .gitignore                  # Git ignore rules
├── rust-toolchain.toml         # Rust version
├── rustfmt.toml                # Format config
├── clippy.toml                 # Lint config
└── benches/
    ├── Cargo.toml              # Benchmark dependencies
    ├── README.md               # Benchmark docs
    ├── build.rs                # Build script
    └── benches/
        ├── *.rs                # 12 benchmark files
        └── *.txt               # 3 test data files
```

## Quick Benchmark Results Comparison

After running benchmarks, compare results:

```bash
# View summary in terminal
cat target/criterion/*/*/estimates.json | jq '.mean.point_estimate'

# Or open HTML report for visual comparison
open target/criterion/report/index.html
```

---

**Need more help?** Check the full documentation in `README.md` and `MIGRATION_GUIDE.md`.
