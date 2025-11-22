# Getting Started with Hydro Benchmarks

Welcome to the Hydro performance benchmarking repository! This guide will help you get started quickly.

## What's in This Repository?

This repository contains **12 performance benchmarks** that compare three dataflow frameworks:
1. **Hydro (dfir_rs)** - The Hydro dataflow framework
2. **Timely-dataflow** - Low-level timely dataflow operations
3. **Differential-dataflow** - Incremental computation framework

Each benchmark implements the same operations in all three frameworks, allowing direct performance comparison.

## Quick Start (5 Minutes)

### 1. Prerequisites Check

You need:
- Rust toolchain installed (get it from https://rustup.rs/)
- Both repositories cloned in `/projects/sandbox/`:
  - `bigweaver-agent-canary-hydro-zeta` (main Hydro repo)
  - `bigweaver-agent-canary-zeta-hydro-deps` (this repo)

### 2. Verify Setup

```bash
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
./setup.sh
```

This script checks:
- ✓ Rust toolchain present
- ✓ Main Hydro repository accessible
- ✓ Dependencies configured correctly
- ✓ Benchmark files present
- ✓ Test data available

### 3. Run Your First Benchmark

```bash
# Run the simplest benchmark (takes ~1 minute)
cargo bench --bench identity

# Results will be displayed in terminal
# HTML report generated in target/criterion/
```

### 4. View Results

```bash
# Open the HTML report
open target/criterion/report/index.html

# Or browse to:
# target/criterion/identity/report/index.html
```

## Understanding Results

When you run a benchmark, you'll see output like:

```
identity/raw              time:   [12.5 ms 12.6 ms 12.7 ms]
identity/timely           time:   [18.2 ms 18.4 ms 18.6 ms]
identity/dfir_rs          time:   [17.9 ms 18.1 ms 18.3 ms]
```

This tells you:
- **identity/raw** - Baseline implementation (theoretical minimum)
- **identity/timely** - Timely-dataflow implementation
- **identity/dfir_rs** - Hydro implementation

Lower numbers = faster performance

## Available Benchmarks

### Quick Tests (< 1 minute each)
```bash
cargo bench --bench identity         # Identity transformations
cargo bench --bench arithmetic       # Arithmetic operations
cargo bench --bench fan_in           # Many-to-one patterns
cargo bench --bench fan_out          # One-to-many patterns
```

### Medium Tests (1-2 minutes each)
```bash
cargo bench --bench join             # Join operations
cargo bench --bench upcase           # String operations
cargo bench --bench fork_join        # Parallel patterns
```

### Intensive Tests (2-5 minutes each)
```bash
cargo bench --bench reachability     # Graph algorithms
cargo bench --bench words_diamond    # Diamond patterns
cargo bench --bench micro_ops        # Comprehensive suite
```

### Run Everything
```bash
cargo bench                          # All benchmarks (~15-30 minutes)
```

## Common Use Cases

### 1. Quick Performance Check
```bash
# Run just one benchmark for quick feedback
cargo bench --bench identity -- --quick
```

### 2. Compare Frameworks
```bash
# Run reachability to see all three frameworks
cargo bench --bench reachability

# Results show relative performance:
# - Hydro vs Timely vs Differential
```

### 3. Track Performance Over Time
```bash
# Save baseline before making changes
cargo bench --bench identity -- --save-baseline before

# Make your changes to Hydro...

# Compare against baseline
cargo bench --bench identity -- --baseline before
```

### 4. Test Specific Operations
```bash
# Test only join-related benchmarks
cargo bench join

# This runs: join, symmetric_hash_join, and related tests
```

## Benchmark Descriptions

| Benchmark | Tests | Good For |
|-----------|-------|----------|
| **identity** | Identity transformations | Framework overhead |
| **arithmetic** | Math operations | Basic operation speed |
| **fan_in** | Many-to-one merging | Aggregation patterns |
| **fan_out** | One-to-many broadcast | Distribution patterns |
| **fork_join** | Parallel split-merge | Parallel processing |
| **join** | Two-way joins | Join performance |
| **symmetric_hash_join** | Hash-based joins | Alternative join impl |
| **reachability** | Graph traversal | Complex dataflow |
| **words_diamond** | Diamond patterns | Complex routing |
| **upcase** | String transforms | Text processing |
| **futures** | Async operations | Async integration |
| **micro_ops** | Comprehensive suite | Overall comparison |

## Next Steps

### Learn More
- Read [EXAMPLES.md](benches/EXAMPLES.md) for detailed benchmark explanations
- Check [QUICK_START.md](benches/QUICK_START.md) for advanced usage
- See [README.md](README.md) for complete documentation

### Explore Implementations
Each benchmark file contains:
1. Baseline implementation (raw Rust)
2. Timely-dataflow implementation
3. Differential-dataflow implementation (when applicable)
4. Hydro implementation(s)

Example: `benches/benches/identity.rs` has 8 different implementations!

### Add Your Own Benchmarks
1. Create `benches/benches/my_benchmark.rs`
2. Add to `Cargo.toml`:
   ```toml
   [[bench]]
   name = "my_benchmark"
   harness = false
   ```
3. Run: `cargo bench --bench my_benchmark`

## Troubleshooting

### Error: "cannot find `dfir_rs`"
**Solution**: Ensure both repositories are in the same parent directory.

Expected structure:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

### Error: "compilation failed"
**Solution**: Update the main Hydro repository:
```bash
cd ../../bigweaver-agent-canary-hydro-zeta
git pull
cargo build
```

### Benchmarks are slow
**Normal**: First run downloads dependencies and compiles everything.
- First run: 5-10 minutes
- Subsequent runs: Much faster

### Want faster feedback
Use `--quick` flag:
```bash
cargo bench --bench identity -- --quick
```

## Tips for Best Results

1. **Close other applications** - Reduces system noise
2. **Use consistent power settings** - Disable CPU throttling
3. **Run multiple times** - Criterion handles this automatically
4. **Compare same machine** - Don't compare across different hardware
5. **Save baselines** - Track performance over time

## Getting Help

- **Setup Issues**: Run `./setup.sh` for diagnostics
- **Usage Questions**: See [QUICK_START.md](benches/QUICK_START.md)
- **Examples**: Read [EXAMPLES.md](benches/EXAMPLES.md)
- **Migration Info**: Check [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) in main repo

## What's Next?

Now that you've run a benchmark:

1. **Compare implementations** - Look at the code in `benches/benches/`
2. **Try different benchmarks** - Each tests different patterns
3. **Modify parameters** - Change NUM_OPS, NUM_INTS in the code
4. **Track changes** - Use baselines to measure improvements
5. **Add benchmarks** - Create your own performance tests

Happy benchmarking! 🚀

---

**Quick Reference Card**

```bash
# Setup
cd /projects/sandbox/bigweaver-agent-canary-zeta-hydro-deps/benches
./setup.sh

# Run benchmarks
cargo bench                      # All benchmarks
cargo bench --bench NAME         # Specific benchmark  
cargo bench -- --quick           # Quick test

# Save/compare
cargo bench -- --save-baseline NAME
cargo bench -- --baseline NAME

# View results
open target/criterion/report/index.html
```
