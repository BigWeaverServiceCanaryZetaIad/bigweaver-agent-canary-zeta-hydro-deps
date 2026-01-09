# Quick Start Guide

Get started with running performance comparison benchmarks in under 5 minutes.

## Prerequisites

- Rust toolchain (see main repository for version requirements)
- Both repositories cloned side by side

## Setup

### 1. Clone Repositories

```bash
# Clone main repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git

# Clone deps repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

### 2. Verify Directory Structure

Ensure your directory structure looks like this:

```
parent_directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

## Running Your First Benchmark

### Run a Single Benchmark

```bash
cd bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench --bench arithmetic
```

### View Results

Results are automatically saved and can be viewed in your browser:

```bash
open target/criterion/report/index.html
```

Or manually navigate to `target/criterion/report/index.html` in your browser.

## Common Commands

### Run All Benchmarks

```bash
cargo bench
```

### Run Specific Benchmark Group

```bash
# Run only arithmetic benchmarks
cargo bench --bench arithmetic

# Run only reachability benchmarks
cargo bench --bench reachability

# Run only join benchmarks
cargo bench --bench join
```

### Filter Benchmarks by Implementation

```bash
# Run only timely implementations
cargo bench -- "timely"

# Run only DFIR implementations
cargo bench -- "hydroflow"

# Run only differential implementations
cargo bench -- "differential"
```

### Compare Against Baseline

```bash
# Save current results as baseline
cargo bench --save-baseline my-baseline

# Make changes...

# Compare against saved baseline
cargo bench --baseline my-baseline
```

## Understanding Output

Criterion will show output like:

```
arithmetic/timely       time:   [156.23 ms 157.45 ms 158.72 ms]
arithmetic/hydroflow    time:   [98.45 ms 99.12 ms 99.89 ms]
                        change: [-37.1% -36.9% -36.7%] (p = 0.00 < 0.05)
                        Performance has improved.
```

This shows:
- Mean execution time with confidence interval
- Performance change compared to previous run
- Statistical significance

## Troubleshooting

### "Cannot find `dfir_rs`"

Ensure both repositories are cloned side by side. The Cargo.toml uses a relative path:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs" }
```

### Slow Compilation

First compilation may take 10-15 minutes as it builds:
- dfir_rs and its dependencies
- timely-dataflow
- differential-dataflow
- criterion

Subsequent builds will be much faster due to caching.

### Inconsistent Results

For more consistent results:
1. Close other applications
2. Disable CPU frequency scaling:
   ```bash
   # Linux
   sudo cpupower frequency-set --governor performance
   ```
3. Run multiple times to establish confidence intervals

## Next Steps

- See [BENCHMARKS.md](BENCHMARKS.md) for detailed benchmark descriptions
- See [README.md](README.md) for full documentation
- Check main repository's CONTRIBUTING.md for development guidelines

## Getting Help

- Open an issue in this repository for benchmark-specific questions
- Refer to the main repository for DFIR/Hydro questions
- See [Criterion.rs User Guide](https://bheisler.github.io/criterion.rs/book/) for benchmark framework questions
