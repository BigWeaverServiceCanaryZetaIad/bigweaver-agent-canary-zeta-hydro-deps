# Quick Start Guide

## Prerequisites

Before you begin, ensure you have:

1. **Rust toolchain** (1.91.1 or later)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Both repositories cloned as siblings:**
   ```bash
   cd /path/to/parent-directory
   git clone <bigweaver-agent-canary-hydro-zeta-url>
   git clone <bigweaver-agent-canary-zeta-hydro-deps-url>
   ```

   Your directory structure should look like:
   ```
   parent-directory/
   ├── bigweaver-agent-canary-hydro-zeta/
   └── bigweaver-agent-canary-zeta-hydro-deps/
   ```

## Running Your First Benchmark

### Step 1: Navigate to the Repository

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Step 2: Build the Project

```bash
cargo build --workspace
```

This will:
- Download and compile dependencies (timely, differential-dataflow, criterion, etc.)
- Build the benchmark harness
- Link against the main repository's dfir_rs package

### Step 3: Run a Simple Benchmark

Start with the identity benchmark (it's fast and straightforward):

```bash
cargo bench --bench identity
```

Expected output:
```
     Running benches/identity.rs
identity/pipeline       time:   [xx.xxx ms xx.xxx ms xx.xxx ms]
identity/raw            time:   [xx.xxx ms xx.xxx ms xx.xxx ms]
identity/iter           time:   [xx.xxx ms xx.xxx ms xx.xxx ms]
...
```

### Step 4: View the Results

Criterion generates detailed HTML reports:

```bash
# On macOS
open target/criterion/report/index.html

# On Linux
xdg-open target/criterion/report/index.html

# Or manually navigate to:
# target/criterion/report/index.html
```

## Running All Benchmarks

To run the complete benchmark suite:

```bash
cargo bench
```

**Note:** This will take several minutes to complete as it runs comprehensive performance tests across all frameworks.

## Running Specific Benchmarks

### By Benchmark Name

```bash
# Identity benchmark
cargo bench --bench identity

# Reachability benchmark (graph algorithms)
cargo bench --bench reachability

# Join operations
cargo bench --bench join
```

### By Test Pattern

You can filter tests by name:

```bash
# Run all identity-related tests
cargo bench identity

# Run all timely-related tests
cargo bench timely

# Run all hydroflow-related tests
cargo bench hydroflow
```

## Understanding the Output

### Console Output

```
identity/hydroflow/surface
                        time:   [12.345 ms 12.456 ms 12.567 ms]
                        change: [-2.3456% -1.2345% +0.1234%] (p = 0.23 > 0.05)
                        No change in performance detected.
```

- **time**: Shows the median, lower bound, and upper bound of execution time
- **change**: Percentage change compared to previous run (if available)
- **p-value**: Statistical significance of the change

### HTML Reports

The HTML reports include:
- Interactive charts showing performance distribution
- Comparison with previous runs
- Statistical analysis
- Raw data export

## Common Tasks

### Save a Baseline for Future Comparisons

```bash
cargo bench -- --save-baseline main
```

### Compare Against a Baseline

```bash
cargo bench -- --baseline main
```

### Run Quick Tests (Reduced Sample Size)

For faster iteration during development:

```bash
cargo bench --bench identity -- --sample-size 10
```

## Next Steps

1. **Explore different benchmarks** - Each benchmark tests different aspects of dataflow performance
2. **Read the comparison guide** - See [BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md) for detailed analysis
3. **Test your changes** - Make modifications to the main repository and measure performance impact
4. **Add new benchmarks** - Contribute additional performance tests

## Troubleshooting

### "Cannot find dfir_rs"

This means the main repository isn't in the expected location. Ensure:
1. Both repositories are cloned
2. They're in the same parent directory
3. The main repository is named `bigweaver-agent-canary-hydro-zeta`

### Build Failures

If you encounter build errors:

```bash
# Clean and rebuild
cargo clean
cargo build --workspace

# Update dependencies
cargo update
```

### Slow Benchmark Execution

Some benchmarks (especially reachability) process large datasets. This is expected. For faster testing:

```bash
# Run only fast benchmarks
cargo bench --bench identity
cargo bench --bench arithmetic
cargo bench --bench micro_ops
```

## Available Benchmarks

| Benchmark | Description | Typical Runtime |
|-----------|-------------|-----------------|
| `identity` | Basic data flow | ~30 seconds |
| `arithmetic` | Math operations | ~1 minute |
| `fan_in` | Fan-in patterns | ~1 minute |
| `fan_out` | Fan-out patterns | ~1 minute |
| `fork_join` | Fork-join patterns | ~1 minute |
| `join` | Join operations | ~2 minutes |
| `upcase` | String operations | ~1 minute |
| `reachability` | Graph algorithms | ~3-5 minutes |
| `micro_ops` | Fine-grained ops | ~2 minutes |
| `symmetric_hash_join` | Hash joins | ~2 minutes |
| `words_diamond` | Text processing | ~1 minute |

## Getting Help

- Check the main [README.md](../README.md)
- Review [BENCHMARKS_COMPARISON.md](BENCHMARKS_COMPARISON.md) for detailed usage
- Consult [MIGRATION.md](MIGRATION.md) for context about the repository structure
- Review the source code of individual benchmarks in `benches/benches/`

## Tips for Best Results

1. **Close other applications** - Minimize background processes for consistent results
2. **Use dedicated hardware** - For reliable measurements, use a dedicated benchmark machine
3. **Run multiple times** - Criterion automatically runs multiple iterations for statistical validity
4. **Check variance** - High variance indicates inconsistent conditions
5. **Compare consistently** - Always compare against a saved baseline from the same machine
