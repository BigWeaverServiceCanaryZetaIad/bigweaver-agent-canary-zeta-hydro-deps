# Setup and Usage Guide

This guide explains how to set up and use the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

- Rust toolchain (specified in `rust-toolchain.toml`)
- Git
- Access to the main bigweaver-agent-canary-hydro-zeta repository

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Build the project:
   ```bash
   cargo build
   ```

3. Run benchmarks:
   ```bash
   cargo bench
   ```

## Directory Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/                      # Benchmark workspace member
│   ├── benches/                  # Actual benchmark files
│   │   ├── arithmetic.rs
│   │   ├── fan_in.rs
│   │   ├── fan_out.rs
│   │   ├── fork_join.rs
│   │   ├── identity.rs
│   │   ├── join.rs
│   │   ├── reachability.rs
│   │   ├── upcase.rs
│   │   ├── reachability_edges.txt
│   │   └── reachability_reachable.txt
│   ├── Cargo.toml
│   └── README.md
├── Cargo.toml                    # Workspace configuration
├── README.md
└── SETUP.md                      # This file
```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run Specific Benchmarks

```bash
# Run just the reachability benchmark
cargo bench --bench reachability

# Run just the arithmetic benchmark
cargo bench --bench arithmetic
```

### Benchmark Options

Criterion supports various command-line options:

```bash
# Reduce sample size for faster runs (useful during development)
cargo bench -- --sample-size 10

# Filter benchmarks by name
cargo bench -- reachability

# Save results as a baseline for comparison
cargo bench -- --save-baseline my-baseline

# Compare against a baseline
cargo bench -- --baseline my-baseline

# Generate detailed statistical output
cargo bench -- --verbose
```

## Performance Comparison Workflow

To compare performance before and after changes:

1. **Save baseline before changes:**
   ```bash
   cargo bench -- --save-baseline before
   ```

2. **Make your changes** to the main repository or locally

3. **Update dependencies** (if changes were in main repo):
   ```bash
   cargo update
   ```

4. **Run benchmarks and compare:**
   ```bash
   cargo bench -- --baseline before
   ```

Criterion will display the performance difference for each benchmark.

## Viewing Results

Benchmark results are saved in `target/criterion/`:

- Open `target/criterion/report/index.html` in a browser for detailed visualizations
- Each benchmark has its own subdirectory with graphs and statistics
- Historical data is preserved for trend analysis

## Git Dependencies

This repository depends on code from the main repository via git dependencies:

- `dfir_rs`: Dataflow IR library
- `sinktools`: Utility tools

These are automatically fetched by Cargo when you build or run benchmarks.

### Using Local Repository for Development

If you're actively developing and want to test changes without pushing to GitHub:

1. Edit `benches/Cargo.toml` to use path dependencies:
   ```toml
   [dev-dependencies]
   dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
   sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools" }
   ```

2. Run benchmarks as usual

3. **Remember to revert to git dependencies before committing!**

## Troubleshooting

### Cargo Cannot Find Git Dependencies

If you see errors about git dependencies:

```bash
# Clear the cargo cache and retry
cargo clean
rm -rf ~/.cargo/git
cargo bench
```

### Benchmark Takes Too Long

Use `--sample-size` to reduce the number of iterations:

```bash
cargo bench -- --sample-size 10
```

### Out of Memory During Benchmarks

Some benchmarks (especially reachability) can use significant memory. Try:

1. Run benchmarks individually
2. Close other applications
3. Increase system swap space if needed

## Contributing

When adding new benchmarks:

1. Add the benchmark file to `benches/benches/`
2. Add a `[[bench]]` section to `benches/Cargo.toml`
3. Update `benches/README.md` with a description
4. Test that it runs: `cargo bench --bench <name>`
5. Commit and submit a pull request

## Continuous Integration

Benchmarks can be integrated into CI/CD pipelines. Example GitHub Actions workflow:

```yaml
name: Benchmarks

on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          profile: minimal
          toolchain: stable
      - name: Run benchmarks
        run: cargo bench --no-fail-fast
```

## License

Apache-2.0 (same as the main repository)
