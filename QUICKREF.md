# Quick Reference Card

## Repository Location
`/projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps`

## Quick Commands

### Run All Benchmarks
```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Individual Benchmarks
```bash
cargo bench --bench arithmetic      # Pipeline arithmetic
cargo bench --bench fan_in          # Fan-in operations
cargo bench --bench fan_out         # Fan-out operations
cargo bench --bench fork_join       # Fork-join pattern
cargo bench --bench identity        # Identity pipeline
cargo bench --bench join            # Join operations
cargo bench --bench reachability    # Graph reachability
cargo bench --bench upcase          # String transformations
```

### Run Specific Test Within Benchmark
```bash
cargo bench --bench arithmetic -- "arithmetic/pipeline"
cargo bench --bench reachability -- "reachability/differential"
```

### View Results
```bash
open target/criterion/report/index.html    # macOS
xdg-open target/criterion/report/index.html # Linux
```

## File Inventory

**Benchmarks (8)**
- arithmetic.rs
- fan_in.rs
- fan_out.rs
- fork_join.rs
- identity.rs
- join.rs
- reachability.rs
- upcase.rs

**Data Files (2)**
- reachability_edges.txt
- reachability_reachable.txt

**Documentation (4)**
- README.md (main)
- SETUP.md
- timely-differential-benches/README.md
- .agents/migration_summary.md

## Dependencies

**Framework**: timely-master 0.13.0-dev.1, differential-dataflow-master 0.13.0-dev.1
**Hydro**: dfir_rs, sinktools (path dependencies)
**Benchmark**: criterion 0.5.0

## Configuration

**Current**: Path dependencies to ../bigweaver-agent-canary-hydro-zeta
**Alternative**: Git dependencies (see Cargo.toml comments)

## Commit Info

**Commit**: 3271c65
**Branch**: setup-dev-environment-20251224-232218
**Date**: 2024-12-24
**Files Added**: 18
**Lines Added**: ~65,000
