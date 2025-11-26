# Quick Start Guide

Get up and running with timely and differential-dataflow benchmarks quickly.

## Prerequisites

- **Rust**: Version 1.91.1 (automatically managed by rust-toolchain.toml)
- **Git**: For repository management
- **Main Repository**: Access to bigweaver-agent-canary-hydro-zeta repository

## Setup Steps

### 1. Clone the Repositories

Ensure both repositories are cloned as sibling directories:

```bash
# Navigate to your workspace
cd /path/to/your/workspace

# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Clone the main repository (required for dependencies)
git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
```

Your directory structure should look like:
```
workspace/
├── bigweaver-agent-canary-zeta-hydro-deps/    # This repository
└── bigweaver-agent-canary-hydro-zeta/          # Main repository
```

### 2. Verify Rust Toolchain

The correct Rust version will be automatically used:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
rustc --version
# Should show: rustc 1.91.1
```

### 3. Build the Benchmarks

```bash
# Build in release mode for accurate benchmarks
cargo build --release -p timely-differential-benches
```

This will:
- Download and compile all dependencies (timely, differential-dataflow, criterion, etc.)
- Compile the benchmark code
- Run the build script to generate fork_join code

First build may take several minutes.

### 4. Run Your First Benchmark

```bash
# Run a simple benchmark
cargo bench -p timely-differential-benches --bench arithmetic
```

This will:
- Compile the benchmark if needed
- Run the arithmetic benchmark comparing timely and hydro
- Generate HTML reports in `target/criterion/`

### 5. View Results

Open the generated report:
```bash
# On Linux
xdg-open target/criterion/report/index.html

# On macOS
open target/criterion/report/index.html

# Or manually navigate to the file in your browser
```

## Common Commands

### Run All Benchmarks
```bash
cargo bench -p timely-differential-benches
```

### Run Specific Benchmark
```bash
cargo bench -p timely-differential-benches --bench <benchmark-name>
```

Available benchmarks:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `identity`
- `join`
- `reachability`
- `upcase`

### Check Code Quality
```bash
# Format code
cargo fmt

# Run linter
cargo clippy -p timely-differential-benches
```

## Troubleshooting

### Issue: "could not find `dfir_rs`"

**Solution**: Ensure the main repository is cloned as a sibling directory:
```bash
ls ..
# Should show: bigweaver-agent-canary-hydro-zeta  bigweaver-agent-canary-zeta-hydro-deps
```

### Issue: "failed to fetch `timely-master`"

**Solution**: Timely and differential-dataflow packages require internet access. Ensure you're online or have these packages cached.

### Issue: Build takes too long

**Solution**: First build can take 10-15 minutes. Subsequent builds are much faster. Use release mode for benchmarks:
```bash
cargo build --release -p timely-differential-benches
```

### Issue: Permission denied errors

**Solution**: Ensure you have write permissions in the repository directory:
```bash
ls -la
# Check ownership and permissions
```

## Next Steps

- **Detailed Instructions**: See [RUNNING_BENCHMARKS.md](RUNNING_BENCHMARKS.md) for comprehensive benchmark options
- **Understanding Results**: Learn how to interpret benchmark results in [RUNNING_BENCHMARKS.md](RUNNING_BENCHMARKS.md)
- **Adding Benchmarks**: Check [benches/README.md](benches/README.md) for benchmark documentation
- **Migration Context**: Read [MIGRATION.md](MIGRATION.md) to understand the repository structure

## Quick Reference

| Task | Command |
|------|---------|
| Build benchmarks | `cargo build --release -p timely-differential-benches` |
| Run all benchmarks | `cargo bench -p timely-differential-benches` |
| Run specific benchmark | `cargo bench -p timely-differential-benches --bench arithmetic` |
| Format code | `cargo fmt` |
| Run linter | `cargo clippy -p timely-differential-benches` |
| Clean build artifacts | `cargo clean` |

## Getting Help

- Review error messages carefully - they often contain solutions
- Check that directory structure matches requirements
- Ensure all dependencies are accessible
- Verify Rust toolchain version: `rustc --version`

For more detailed information, see the full documentation files in this repository.
