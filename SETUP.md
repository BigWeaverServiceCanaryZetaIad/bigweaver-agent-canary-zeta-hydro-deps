# Setup and Usage Guide

## Overview

This repository contains benchmarks that were moved from the main `bigweaver-agent-canary-hydro-zeta` repository. The benchmarks depend on `timely` and `differential-dataflow` packages and have been isolated here to prevent dependency bloat in the main repository.

## Prerequisites

- Rust toolchain (see `rust-toolchain.toml` for the specific version)
- Git access to the main repository (for `dfir_rs` and `sinktools` dependencies)

## Initial Setup

1. Clone this repository:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the project:
   ```bash
   cargo build --release
   ```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

### Run Specific Benchmarks

Each benchmark can be run individually:

```bash
# Arithmetic operations benchmark
cargo bench -p benches --bench arithmetic

# Fan-in benchmark
cargo bench -p benches --bench fan_in

# Fan-out benchmark
cargo bench -p benches --bench fan_out

# Fork-join benchmark
cargo bench -p benches --bench fork_join

# Futures benchmark
cargo bench -p benches --bench futures

# Identity benchmark
cargo bench -p benches --bench identity

# Join benchmark
cargo bench -p benches --bench join

# Micro operations benchmark
cargo bench -p benches --bench micro_ops

# Reachability benchmark
cargo bench -p benches --bench reachability

# Symmetric hash join benchmark
cargo bench -p benches --bench symmetric_hash_join

# Upcase benchmark
cargo bench -p benches --bench upcase

# Words diamond benchmark
cargo bench -p benches --bench words_diamond
```

## Benchmark Results

Benchmark results are stored in `target/criterion/` and include:
- HTML reports with graphs
- Raw measurement data
- Statistical analysis

To view results, open `target/criterion/report/index.html` in a web browser.

## Performance Comparisons

### Comparing Between Commits

1. Run benchmarks on the baseline commit:
   ```bash
   git checkout <baseline-commit>
   cargo bench -p benches
   ```

2. Run benchmarks on the new commit:
   ```bash
   git checkout <new-commit>
   cargo bench -p benches
   ```

Criterion will automatically compare the results and show the performance differences.

### Comparing with Main Repository

To compare performance with the main repository (before the benchmarks were moved):

1. In the main repository, checkout a commit before the benchmarks were removed:
   ```bash
   cd /path/to/bigweaver-agent-canary-hydro-zeta
   git checkout 484e6fdd  # Or any commit before the benchmarks were removed
   cargo bench -p benches
   ```

2. Copy the criterion results:
   ```bash
   cp -r target/criterion /tmp/main-repo-results
   ```

3. Run benchmarks in this repository:
   ```bash
   cd /path/to/bigweaver-agent-canary-zeta-hydro-deps
   cargo bench -p benches
   ```

4. Compare the results manually by examining the reports in both locations.

## Development

### Adding New Benchmarks

1. Add a new `.rs` file in `benches/benches/`
2. Add a `[[bench]]` section in `benches/Cargo.toml`
3. Run `cargo bench -p benches --bench <new-bench-name>` to verify

### Updating Dependencies

The benchmarks depend on `dfir_rs` and `sinktools` from the main repository via git dependencies. To update to the latest version:

```bash
cargo update -p dfir_rs -p sinktools
```

To pin to a specific commit:

1. Edit `benches/Cargo.toml`
2. Add `rev = "<commit-hash>"` to the git dependencies
3. Run `cargo update`

## Troubleshooting

### Build Failures

If the build fails due to missing dependencies:
1. Ensure you have network access to the main repository
2. Try `cargo clean && cargo build --release`
3. Check that the main repository is accessible at the git URL

### Benchmark Failures

If benchmarks fail or produce unexpected results:
1. Ensure no other intensive processes are running
2. Run benchmarks with `--nocapture` for more output: `cargo bench -p benches -- --nocapture`
3. Check that data files (e.g., `words_alpha.txt`, `reachability_edges.txt`) are present in `benches/benches/`

## CI/CD

The repository includes GitHub Actions workflow for automated benchmarking:
- Triggered on schedule (daily)
- Can be manually triggered via workflow dispatch
- Can be triggered by including `[ci-bench]` in commit messages or PR titles

See `.github/workflows/benchmark.yml` for details.
