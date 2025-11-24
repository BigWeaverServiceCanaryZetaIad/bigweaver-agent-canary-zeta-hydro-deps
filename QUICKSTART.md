# Quick Start Guide

This guide will help you get started with running benchmarks in the bigweaver-agent-canary-zeta-hydro-deps repository.

## Prerequisites

1. **Rust Toolchain**: The project uses Rust 1.91.1 (specified in `rust-toolchain.toml`)
   - Install via [rustup](https://rustup.rs/): `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
   - The correct toolchain will be automatically installed when you first run cargo

2. **Git Access**: You need access to the BigWeaverServiceCanaryZetaIad organization repositories

## Installation

1. Clone this repository:
   ```bash
   git clone https://zeta.us-east-1.modeled-gateway.integrations.bigweaver.aws.dev/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   cd bigweaver-agent-canary-zeta-hydro-deps
   ```

2. Verify the setup:
   ```bash
   cargo check -p benches
   ```

## Running Benchmarks

### Run All Benchmarks

```bash
cargo bench -p benches
```

This will run all benchmarks and generate HTML reports in `target/criterion/`.

### Run a Single Benchmark

```bash
cargo bench -p benches --bench arithmetic
```

Replace `arithmetic` with any benchmark name:
- `arithmetic`
- `fan_in`
- `fan_out`
- `fork_join`
- `futures`
- `identity`
- `join`
- `micro_ops`
- `reachability`
- `symmetric_hash_join`
- `upcase`
- `words_diamond`

### Quick Benchmark Run (Faster)

For development and testing:

```bash
cargo bench -p benches -- --quick
```

### Run Specific Benchmark Functions

```bash
# Run only specific test cases within a benchmark
cargo bench -p benches --bench arithmetic -- "Arithmetic/dfir"
```

## Viewing Results

After running benchmarks, results are saved in:
- **Console Output**: Summary statistics printed to terminal
- **HTML Reports**: `target/criterion/*/report/index.html`
- **Raw Data**: `target/criterion/*/raw.csv`

To view HTML reports:
```bash
# Open the main criterion report index
open target/criterion/report/index.html  # macOS
xdg-open target/criterion/report/index.html  # Linux
```

## Performance Comparison

The benchmarks compare multiple implementations:

1. **Timely** - Timely dataflow implementation
2. **Differential** - Differential dataflow implementation
3. **Hydroflow/dfir** - The Hydroflow implementation
4. **Raw Rust** - Baseline Rust implementation

Results are organized by benchmark type and implementation variant.

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update dependencies**:
   ```bash
   cargo update
   ```

2. **Clean build cache**:
   ```bash
   cargo clean
   cargo build -p benches
   ```

3. **Check network access**: Ensure you can access the main repository for git dependencies

### Benchmark Failures

If benchmarks fail to run:

1. **Check available memory**: Some benchmarks are memory-intensive
2. **Verify test data**: Ensure data files in `benches/benches/` are present
3. **Run with verbose output**:
   ```bash
   cargo bench -p benches --bench <name> -- --verbose
   ```

### Performance Issues

If benchmarks run slowly:

1. Use `--quick` flag for faster iteration
2. Run specific benchmarks instead of all
3. Check system load (benchmarks are CPU-intensive)

## Next Steps

- Read the main [README.md](README.md) for comprehensive documentation
- Explore individual benchmark source files in `benches/benches/`
- Check the [main repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) for context

## Getting Help

- Review benchmark source code for implementation details
- Check criterion documentation: https://bheisler.github.io/criterion.rs/book/
- Refer to the main repository's CONTRIBUTING.md for team practices
