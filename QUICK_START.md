# Quick Start Guide

## Installation

```bash
# Clone the repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Build (first time will take a while to fetch and compile dependencies)
cargo build

# Run all benchmarks
cargo bench
```

## Running Specific Benchmarks

```bash
# Run a single benchmark
cargo bench --bench reachability

# Run multiple specific benchmarks
cargo bench --bench arithmetic --bench join

# List available benchmarks
cargo bench --help
```

## Available Benchmarks

| Benchmark | Description |
|-----------|-------------|
| `arithmetic` | Arithmetic operations performance |
| `fan_in` | Fan-in dataflow pattern |
| `fan_out` | Fan-out dataflow pattern |
| `fork_join` | Fork-join parallel pattern |
| `futures` | Async futures handling |
| `identity` | Identity transformations |
| `join` | Join operations |
| `micro_ops` | Micro-level operations |
| `reachability` | Graph reachability algorithms |
| `symmetric_hash_join` | Symmetric hash join |
| `upcase` | String transformations |
| `words_diamond` | Diamond pattern processing |

## Viewing Results

Results are saved as HTML reports in `target/criterion/`:

```bash
# View all results
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Common Issues

**Build takes too long?**
- First build compiles all dependencies including Hydro crates from git
- Subsequent builds will be much faster
- Use `cargo build --release` for optimized builds

**Network errors during build?**
- Ensure you have internet access to clone git dependencies
- Check GitHub connectivity: `git ls-remote https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git`

**Benchmark failures?**
- Ensure all data files are present in `benches/` directory
- Run `cargo check` to verify dependencies are correct

## Next Steps

- See [SETUP.md](SETUP.md) for detailed setup instructions
- See [README.md](README.md) for comprehensive documentation
- See [MIGRATION.md](MIGRATION.md) for information about the repository migration
