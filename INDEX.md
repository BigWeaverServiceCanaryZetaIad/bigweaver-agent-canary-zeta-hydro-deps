# Repository Index

Complete index of files and documentation in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Documentation

### Quick Start
- **[README.md](README.md)** - Repository overview and quick start guide
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Fast reference for common operations

### Detailed Guides
- **[BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Comprehensive benchmark guide with detailed explanations
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contributing guidelines and development setup
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and changes

### Benchmark-Specific
- **[benches/README.md](benches/README.md)** - Benchmark package documentation

## Configuration Files

### Rust Tooling
- **[rust-toolchain.toml](rust-toolchain.toml)** - Rust version and components (1.91.1)
- **[rustfmt.toml](rustfmt.toml)** - Code formatting configuration
- **[clippy.toml](clippy.toml)** - Linting rules configuration

### Workspace
- **[Cargo.toml](Cargo.toml)** - Workspace configuration and build profiles

### Benchmarks
- **[benches/Cargo.toml](benches/Cargo.toml)** - Benchmark dependencies and configuration
- **[benches/build.rs](benches/build.rs)** - Build script for benchmarks

## Helper Scripts

- **[run_benchmarks.sh](run_benchmarks.sh)** - Convenient benchmark runner
  - Usage: `./run_benchmarks.sh [benchmark_name]`
  - Options: `--list`, `--help`

- **[verify_setup.sh](verify_setup.sh)** - Setup verification script
  - Usage: `./verify_setup.sh`
  - Checks: Repository structure, dependencies, compilation

## Benchmarks

### Source Files (in benches/benches/)

#### Graph Operations
- **[reachability.rs](benches/benches/reachability.rs)** - Graph reachability algorithms
  - Implementations: timely, differential, dfir_rs (scheduled, standard, surface)
  - Data files: `reachability_edges.txt`, `reachability_reachable.txt`

- **[join.rs](benches/benches/join.rs)** - Join operations
- **[symmetric_hash_join.rs](benches/benches/symmetric_hash_join.rs)** - Symmetric hash joins

#### Data Flow Patterns
- **[fan_in.rs](benches/benches/fan_in.rs)** - Multiple sources merging
- **[fan_out.rs](benches/benches/fan_out.rs)** - Single source splitting
- **[fork_join.rs](benches/benches/fork_join.rs)** - Fork-join parallelism
- **[identity.rs](benches/benches/identity.rs)** - Pass-through operations

#### Real-World Scenarios
- **[words_diamond.rs](benches/benches/words_diamond.rs)** - Diamond pattern word processing
  - Data file: `words_alpha.txt`
- **[upcase.rs](benches/benches/upcase.rs)** - String transformations

#### Micro Benchmarks
- **[micro_ops.rs](benches/benches/micro_ops.rs)** - Micro-operations and basic patterns
- **[arithmetic.rs](benches/benches/arithmetic.rs)** - Mathematical operations

#### Async Operations
- **[futures.rs](benches/benches/futures.rs)** - Futures-based async operations

### Data Files (in benches/benches/)
- **reachability_edges.txt** - Graph edges for reachability (524KB)
- **reachability_reachable.txt** - Expected reachable nodes (40KB)
- **words_alpha.txt** - English words dictionary (3.7MB)

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
│
├── Documentation
│   ├── BENCHMARK_GUIDE.md          # Comprehensive guide
│   ├── CHANGELOG.md                # Version history
│   ├── CONTRIBUTING.md             # Contributing guidelines
│   ├── INDEX.md                    # This file
│   ├── QUICK_REFERENCE.md          # Quick reference
│   └── README.md                   # Main documentation
│
├── Configuration
│   ├── Cargo.toml                  # Workspace configuration
│   ├── clippy.toml                 # Clippy configuration
│   ├── rust-toolchain.toml         # Rust toolchain
│   └── rustfmt.toml                # Rustfmt configuration
│
├── Scripts
│   ├── run_benchmarks.sh           # Benchmark runner
│   └── verify_setup.sh             # Setup verification
│
└── benches/                        # Benchmark package
    ├── Cargo.toml                  # Dependencies
    ├── README.md                   # Package docs
    ├── build.rs                    # Build script
    └── benches/                    # Benchmark files
        ├── arithmetic.rs
        ├── fan_in.rs
        ├── fan_out.rs
        ├── fork_join.rs
        ├── futures.rs
        ├── identity.rs
        ├── join.rs
        ├── micro_ops.rs
        ├── reachability.rs
        ├── reachability_edges.txt
        ├── reachability_reachable.txt
        ├── symmetric_hash_join.rs
        ├── upcase.rs
        ├── words_alpha.txt
        └── words_diamond.rs
```

## Quick Links

### Getting Started
1. [Setup Verification](verify_setup.sh) - Run first to verify setup
2. [Quick Reference](QUICK_REFERENCE.md) - Common commands
3. [Run Benchmarks](run_benchmarks.sh) - Start benchmarking

### Learning More
1. [Benchmark Guide](BENCHMARK_GUIDE.md) - Detailed information
2. [Contributing](CONTRIBUTING.md) - Development guidelines
3. [Changelog](CHANGELOG.md) - Version history

### Common Tasks

#### Run Benchmarks
```bash
./run_benchmarks.sh                     # All benchmarks
./run_benchmarks.sh reachability        # Specific benchmark
./run_benchmarks.sh --list              # List available
```

#### Verify Setup
```bash
./verify_setup.sh                       # Full verification
cargo check --workspace                 # Quick check
```

#### View Results
```bash
open target/criterion/report/index.html # HTML reports
ls target/criterion/                    # All results
```

## Dependencies

### External Crates
- **criterion** 0.5.0 - Benchmarking framework
- **timely-master** 0.13.0-dev.1 - Timely dataflow
- **differential-dataflow-master** 0.13.0-dev.1 - Differential dataflow
- **tokio** 1.29.0 - Async runtime
- **futures** 0.3 - Futures utilities
- **rand** 0.8.0 - Random number generation

### Path Dependencies (from main repository)
- **dfir_rs** - DFIR runtime (`../../bigweaver-agent-canary-hydro-zeta/dfir_rs`)
- **sinktools** - Sink utilities (`../../bigweaver-agent-canary-hydro-zeta/sinktools`)

## Output Locations

### Benchmark Results
```
target/criterion/
├── report/
│   └── index.html              # Main HTML report
├── reachability/               # Reachability results
│   ├── timely/
│   ├── differential/
│   └── dfir_rs/
├── arithmetic/                 # Arithmetic results
└── [other benchmarks]/         # Other benchmark results
```

### Build Artifacts
```
target/
├── debug/                      # Debug builds
├── release/                    # Release builds (used for benchmarks)
└── criterion/                  # Benchmark results
```

## Related Repositories

- **[bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta/)** - Main Hydro repository
  - Contains `dfir_rs` and `sinktools` dependencies
  - See [BENCHMARK_REMOVAL.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL.md) for migration details

## Additional Resources

### External Documentation
- [Criterion.rs Book](https://bheisler.github.io/criterion.rs/book/)
- [Timely Dataflow](https://timelydataflow.github.io/timely-dataflow/)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Rust Documentation](https://doc.rust-lang.org/)

### Repository Links
- Main Repository: [bigweaver-agent-canary-hydro-zeta](../bigweaver-agent-canary-hydro-zeta/)
- GitHub: [hydro-project/hydro](https://github.com/hydro-project/hydro)

## Maintenance

### Adding New Benchmarks
1. Create benchmark file in `benches/benches/`
2. Add entry to `benches/Cargo.toml`
3. Update documentation:
   - This INDEX.md
   - BENCHMARK_GUIDE.md
   - QUICK_REFERENCE.md
4. Update `run_benchmarks.sh` --list output
5. Document in CHANGELOG.md

### Updating Dependencies
1. Edit `benches/Cargo.toml`
2. Test: `cargo check -p benches`
3. Run benchmarks: `cargo bench -p benches -- --sample-size 10`
4. Document in CHANGELOG.md

### Documentation Updates
- Keep all documentation synchronized
- Update CHANGELOG.md for significant changes
- Maintain consistent formatting and structure

## Support

For questions or issues:
1. Review documentation files
2. Run `./verify_setup.sh`
3. Check main repository's [BENCHMARK_REMOVAL.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_REMOVAL.md)
4. Refer to [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines

---

**Last Updated**: November 2025
**Repository Version**: Initial Release
