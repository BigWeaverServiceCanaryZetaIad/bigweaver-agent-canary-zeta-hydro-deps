# Setup Guide

This repository contains benchmarks that compare different dataflow implementations. Most benchmarks compare Hydro (dfir_rs) performance against timely and differential-dataflow implementations.

## Prerequisites

1. Rust toolchain (see main repository for version requirements)
2. Access to the bigweaver-agent-canary-hydro-zeta repository

## Quick Setup

### Step 1: Clone Both Repositories

Clone both repositories in the same parent directory:

```bash
# Choose a parent directory
cd /path/to/your/projects

# Clone the main Hydro repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone this deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

Your directory structure should look like:
```
/path/to/your/projects/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Step 2: Configure Path Dependencies

Edit `benches/Cargo.toml` in this repository and uncomment the following lines:

```toml
[dev-dependencies]
# ... other dependencies ...
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

**Note**: If your repositories are not in the same parent directory, adjust the paths accordingly.

### Step 3: Build and Test

```bash
cd bigweaver-agent-canary-zeta-hydro-deps

# Build to verify dependencies are working
cargo build --release

# Run benchmarks
cargo bench
```

## Benchmark Types

### Full Comparison Benchmarks (Require dfir_rs)
These benchmarks compare Hydro, timely, and sometimes other implementations:
- `arithmetic` - Arithmetic operations across frameworks
- `fan_in` - Fan-in patterns
- `fan_out` - Fan-out patterns
- `fork_join` - Fork-join patterns
- `identity` - Identity operations
- `reachability` - Graph reachability

### Timely-Only Benchmarks (No dfir_rs Required)
These benchmarks focus on timely/differential implementations:
- `join` - Join operations in timely
- `upcase` - String transformation in timely

## Running Individual Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench arithmetic

# Run benchmark with specific filter
cargo bench --bench arithmetic -- "timely"
```

## Troubleshooting

### Error: "package `dfir_rs` not found"

**Solution**: Uncomment the path dependencies in `benches/Cargo.toml` as described in Step 2.

### Error: Path not found

**Solution**: Adjust the paths in `benches/Cargo.toml` to match your repository layout.

### Build errors from dfir_rs

**Solution**: Make sure the main repository is on a compatible commit. Try:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
git pull
cargo build
```

## Alternative Setup: Published Crates

If dfir_rs is published to crates.io, you can use the published version instead:

```toml
[dev-dependencies]
dfir_rs = { version = "0.14.0", features = [ "debugging" ] }
sinktools = { version = "0.0.1" }
```

However, this may not include the latest features or bug fixes from the main repository.

## For Contributors

When adding new benchmarks:
1. Follow the existing benchmark patterns
2. Use criterion for benchmarking infrastructure
3. Document any new dependencies in this guide
4. Update the main README.md with new benchmark descriptions
