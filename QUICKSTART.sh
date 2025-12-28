#!/bin/bash
# Quick Start Guide for Running Benchmarks
# This script provides common benchmark commands and examples

cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════╗
║  Hydro Timely/Differential-Dataflow Benchmarks - Quick Start     ║
╚═══════════════════════════════════════════════════════════════════╝

BASIC USAGE
───────────

Run all benchmarks:
  $ cargo bench -p hydro-timely-differential-benches

Run specific benchmark:
  $ cargo bench -p hydro-timely-differential-benches --bench <name>

Available benchmarks:
  - arithmetic      Sequential map operations (1M elements, 20 ops)
  - fan_in          Multiple input streams merging
  - fan_out         Single stream splitting
  - fork_join       Fork-join with filtering (20 levels)
  - identity        Framework overhead measurement
  - join            Hash join operations (100K pairs)
  - reachability    Graph reachability (differential)
  - upcase          String transformations

EXAMPLES
────────

# Run arithmetic benchmark
$ cargo bench -p hydro-timely-differential-benches --bench arithmetic

# Run reachability benchmark
$ cargo bench -p hydro-timely-differential-benches --bench reachability

# Run join benchmark
$ cargo bench -p hydro-timely-differential-benches --bench join

# Run only timely comparisons in arithmetic
$ cargo bench -p hydro-timely-differential-benches --bench arithmetic -- "timely"

# Run only specific join type
$ cargo bench -p hydro-timely-differential-benches --bench join -- "usize/usize"

ADVANCED OPTIONS
────────────────

# Faster benchmarking (fewer samples)
$ cargo bench -p hydro-timely-differential-benches -- --sample-size 10

# Generate HTML reports (no plots)
$ cargo bench -p hydro-timely-differential-benches -- --noplot
# Reports will be in: target/criterion/

# Save baseline for comparison
$ cargo bench -p hydro-timely-differential-benches -- --save-baseline my-baseline

# Compare against saved baseline
$ cargo bench -p hydro-timely-differential-benches -- --baseline my-baseline

# Profile benchmarks
$ cargo bench -p hydro-timely-differential-benches --profile profile -- --profile-time=5

BUILD AND TEST
──────────────

# Build benchmarks without running
$ cargo build -p hydro-timely-differential-benches --benches

# Check if everything compiles
$ cargo check -p hydro-timely-differential-benches

# Run with verbose output
$ cargo bench -p hydro-timely-differential-benches -- --verbose

CROSS-REPOSITORY WORKFLOW
──────────────────────────

# Run main repository benchmarks (without timely/differential)
$ cd ../bigweaver-agent-canary-hydro-zeta
$ cargo bench -p benches

# Run comparison benchmarks (with timely/differential)
$ cd ../bigweaver-agent-canary-zeta-hydro-deps
$ cargo bench -p hydro-timely-differential-benches

TROUBLESHOOTING
───────────────

Path dependency errors:
  Ensure both repositories are in the same parent directory:
    parent-directory/
    ├── bigweaver-agent-canary-hydro-zeta/
    └── bigweaver-agent-canary-zeta-hydro-deps/

Slow execution:
  - Run specific benchmarks instead of all
  - Use --sample-size to reduce iterations
  - Close resource-intensive applications

DOCUMENTATION
─────────────

Detailed documentation:
  - README.md                 Repository overview
  - CONTRIBUTING.md           Development guidelines
  - benches/README.md         Comprehensive benchmark docs

Online resources:
  - Hydro: https://hydro.run/
  - Criterion: https://bheisler.github.io/criterion.rs/book/

EXAMPLE WORKFLOW
────────────────

# 1. Build to check everything compiles
$ cargo build -p hydro-timely-differential-benches --benches

# 2. Run a quick test with reduced samples
$ cargo bench -p hydro-timely-differential-benches --bench identity -- --sample-size 10

# 3. Run full benchmark suite
$ cargo bench -p hydro-timely-differential-benches

# 4. Check results in HTML reports
$ cargo bench -p hydro-timely-differential-benches -- --noplot
$ firefox target/criterion/index.html  # or your browser

Need help? See README.md and CONTRIBUTING.md for more information.

EOF
