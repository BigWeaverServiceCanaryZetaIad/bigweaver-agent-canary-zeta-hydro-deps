# Configuration Guide

This document provides detailed configuration information for the benchmark repository.

## Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── .github/
│   ├── workflows/
│   │   └── benchmark.yml          # CI/CD workflow for benchmarks
│   └── gh-pages/
│       ├── .gitignore             # gh-pages branch gitignore
│       └── index.md               # GitHub Pages landing page
├── benches/
│   ├── benches/                   # Benchmark test files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── futures.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── micro_ops.rs
│   │   ├── reachability.rs
│   │   ├── symmetric_hash_join.rs
│   │   ├── upcase.rs
│   │   ├── words_diamond.rs
│   │   ├── reachability_edges.txt      # Test data
│   │   ├── reachability_reachable.txt  # Test data
│   │   └── words_alpha.txt             # Test data
│   ├── Cargo.toml                 # Benchmark package configuration
│   ├── build.rs                   # Build script for code generation
│   └── README.md                  # Benchmark usage guide
├── Cargo.toml                     # Workspace configuration
├── rust-toolchain.toml            # Rust toolchain specification
├── .gitignore                     # Git ignore rules
├── README.md                      # Repository overview
├── MIGRATION.md                   # Migration documentation
└── CONFIGURATION.md               # This file
```

## Dependency Configuration

### Git Dependencies

The benchmarks depend on packages from the main Hydro repository. These are configured as git dependencies in `benches/Cargo.toml`:

```toml
[dev-dependencies]
# Dependencies from the main Hydro repository
dfir_rs = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", features = [ "debugging" ] }
sinktools = { git = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git", branch = "main", version = "^0.0.1" }
```

### Local Development

For local development where you want to test against a local checkout of the main repository:

1. Clone both repositories:
```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

2. Temporarily modify `benches/Cargo.toml` to use path dependencies:
```toml
[dev-dependencies]
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

3. After testing, revert to git dependencies before committing.

### External Framework Dependencies

The benchmarks compare DFIR with external dataflow frameworks:

```toml
# Timely Dataflow
timely = { package = "timely-master", version = "0.13.0-dev.1" }

# Differential Dataflow
differential-dataflow = { package = "differential-dataflow-master", version = "0.13.0-dev.1" }
```

These use renamed packages (`-master` suffix) to track development versions.

### Benchmarking Framework

```toml
criterion = { version = "0.5.0", features = [ "async_tokio", "html_reports" ] }
```

Criterion is configured with:
- `async_tokio` - Support for async benchmarks
- `html_reports` - Generate HTML reports

## CI/CD Configuration

### Workflow Triggers

The benchmark workflow (`.github/workflows/benchmark.yml`) triggers on:

1. **Schedule**: Daily at 3:35 AM UTC
   ```yaml
   schedule:
     - cron: "35 03 * * *"
   ```

2. **Push to main**: With `[ci-bench]` in commit message
   ```yaml
   if: contains(github.event.head_commit.message, '[ci-bench]')
   ```

3. **Pull Request**: With `[ci-bench]` in title or body
   ```yaml
   if: contains(github.event.pull_request.title, '[ci-bench]') ||
       contains(github.event.pull_request.body, '[ci-bench]')
   ```

4. **Manual Dispatch**: Via GitHub Actions UI
   ```yaml
   workflow_dispatch:
     inputs:
       should_bench:
         description: "Should Benchmark? (`true`)"
         required: true
         default: "false"
   ```

### Benchmark Execution

The workflow runs two sets of benchmarks:

```yaml
- name: Run benchmark
  run: |
    # Run DFIR benchmarks
    time cargo bench -p benches -- dfir --output-format bencher | tee output.txt
    # Run micro operations benchmarks
    time cargo bench -p benches -- micro/ops/ --output-format bencher | tee -a output.txt
```

### Results Publication

Results are published to GitHub Pages:

1. Checkout gh-pages branch
2. Run benchmarks and generate reports
3. Update benchmark data (JSON format)
4. Generate HTML visualization
5. Commit and push to gh-pages branch

Only main branch benchmarks are published (not PRs).

## Workspace Configuration

### Cargo Workspace

```toml
[workspace]
resolver = "2"
members = [
    "benches",
]
```

Uses Cargo's new feature resolver (version 2) for consistent dependency resolution.

### Workspace-level Settings

```toml
[workspace.package]
version = "0.0.0"
edition = "2021"
license = "Apache-2.0"
repository = "https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps"
```

Shared metadata for all workspace members.

### Lints

```toml
[workspace.lints.clippy]
uninlined_format_args = "allow"

[workspace.lints.rust]
unsafe_code = "deny"
missing_docs = "allow"
```

Workspace-wide lint configuration applied to all members.

## Rust Toolchain

Specified in `rust-toolchain.toml`:

```toml
[toolchain]
channel = "1.89.0"
components = [
    "rustfmt",
    "clippy",
    "rust-src",
]
targets = ["wasm32-unknown-unknown", "x86_64-unknown-linux-musl"]
```

- **Rust Version**: 1.89.0 (stable)
- **Components**: Formatting, linting, and source code
- **Targets**: WASM and Linux musl for cross-compilation

## Build Configuration

### Build Script

`benches/build.rs` generates benchmark code at build time:

- Generates fork-join benchmark with configurable number of operations
- Creates `.hf` files with DFIR syntax
- Runs automatically before compilation

### Build Settings

```toml
[package]
name = "benches"
publish = false    # Not published to crates.io
version = "0.0.0"  # Internal version
```

## Benchmark Configuration

### Criterion Settings

Each benchmark is configured with:

```toml
[[bench]]
name = "arithmetic"
harness = false    # Use Criterion instead of default harness
```

Setting `harness = false` tells Cargo to use Criterion's benchmark harness.

### Benchmark Parameters

Key parameters defined in benchmark files:

```rust
const NUM_OPS: usize = 20;        // Number of operations
const NUM_INTS: usize = 1_000_000; // Data size
```

Adjust these to change benchmark characteristics.

## Performance Comparison

### Frameworks Compared

Each benchmark compares three implementations:

1. **DFIR** - Hydro's dataflow framework
   - Uses `dfir_syntax!` macro
   - Hydro-specific operators

2. **Timely** - Timely Dataflow
   - Uses `timely::dataflow` APIs
   - Worker/dataflow scope model

3. **Differential** - Differential Dataflow
   - Uses `differential_dataflow` APIs
   - Incremental computation model

### Metrics Collected

- **Throughput**: Operations per second
- **Latency**: Time per operation
- **Scalability**: Performance vs. data size
- **Overhead**: Framework overhead vs. baseline

## GitHub Pages Configuration

### Jekyll Settings

GitHub Pages uses Jekyll to render the index page:

```markdown
---
---
# Content here
```

Front matter is required for Jekyll processing.

### Links

```markdown
- [Benchmark History]({{ "/bench/" | prepend: site.github.url | replace: 'https://', '//' }})
- [Latest Benchmarks]({{ "/criterion/report/" | prepend: site.github.url | replace: 'https://', '//' }})
```

Uses Jekyll variables for dynamic URL generation.

## Environment Variables

### CI Environment

Set in workflow:

```yaml
env:
  WWW_DIR: target  # Directory for gh-pages checkout
```

### Git Configuration

For publishing results:

```yaml
git -c 'user.name=github-actions[bot]' \
    -c 'user.email=41898282+github-actions[bot]@users.noreply.github.com' \
    commit -m "Update Benchmarks"
```

## Troubleshooting

### Dependency Issues

If benchmarks fail to compile:

1. Check that main Hydro repository builds successfully
2. Update git dependency revisions if needed
3. Verify Rust toolchain version matches

### CI/CD Issues

If workflow doesn't trigger:

1. Verify `[ci-bench]` tag in commit/PR
2. Check workflow permissions
3. Ensure gh-pages branch exists

### Performance Regression

If benchmarks show regression:

1. Check for changes in main Hydro repository
2. Review recent commits to dependencies
3. Verify test data hasn't changed

## Maintenance

### Regular Updates

1. **Weekly**: Review benchmark results
2. **Monthly**: Update dependencies
3. **Quarterly**: Review and update benchmarks

### Dependency Updates

Update git dependencies when main repository has significant changes:

```toml
dfir_rs = { git = "...", rev = "specific-commit-hash", features = [...] }
```

Pin to specific commit for reproducibility.

### Adding New Benchmarks

1. Create benchmark file in `benches/benches/`
2. Add benchmark entry to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Follow existing benchmark patterns
4. Update documentation

## Best Practices

### Running Benchmarks Locally

```bash
# Run all benchmarks
cargo bench -p benches

# Run with specific filter
cargo bench -p benches -- dfir

# Generate criterion reports
cargo bench -p benches --bench arithmetic -- --save-baseline my-baseline
```

### Comparing Results

```bash
# Save baseline
cargo bench -p benches -- --save-baseline before

# Make changes...

# Compare against baseline
cargo bench -p benches -- --baseline before
```

### Profiling

Use built-in profiling:

```bash
cargo bench -p benches -- --profile-time=5
```

## Security Considerations

### Secrets

The workflow uses `secrets.GITHUB_TOKEN` for:
- Publishing to gh-pages
- Uploading artifacts

This is automatically provided by GitHub Actions.

### Permissions

Required permissions:

```yaml
permissions:
  contents: write  # For pushing to gh-pages
```

## Future Enhancements

Potential improvements:

1. **Parameterized Benchmarks**: Add configuration file for benchmark parameters
2. **Regression Detection**: Automated alerts for performance regressions
3. **Comparison Reports**: Side-by-side framework comparison
4. **Custom Metrics**: Domain-specific performance metrics
5. **Memory Profiling**: Track memory usage alongside runtime

## References

- [Criterion Documentation](https://bheisler.github.io/criterion.rs/book/)
- [GitHub Actions Workflow Syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Cargo Workspaces](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html)
- [GitHub Pages](https://docs.github.com/en/pages)
