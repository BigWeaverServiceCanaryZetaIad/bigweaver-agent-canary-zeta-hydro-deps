# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that were separated from the main [`bigweaver-agent-canary-hydro-zeta`](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce build times and dependency overhead.

## Contents

### Timely/Differential-Dataflow Benchmarks

The `timely-differential-benches` package contains performance benchmarks comparing various dataflow implementations:

**Migrated Benchmarks:**
- `arithmetic.rs` - Arithmetic operations benchmark
- `fan_in.rs` - Fan-in pattern benchmark
- `fan_out.rs` - Fan-out pattern benchmark  
- `fork_join.rs` - Fork-join pattern benchmark
- `identity.rs` - Identity operation benchmark
- `join.rs` - Join operation benchmark
- `reachability.rs` - Graph reachability benchmark (includes edge data files)
- `upcase.rs` - String uppercasing benchmark

## Why This Repository Exists

The benchmarks in this repository depend on `timely-dataflow` and `differential-dataflow`, which are heavyweight dependencies. By separating them into their own repository:

1. **Faster builds** - The main repository builds faster without these dependencies
2. **Reduced complexity** - Developers working on core functionality don't need to compile timely/differential
3. **Maintained comparisons** - We can still run performance comparisons between implementations
4. **Cleaner separation** - External dependencies are isolated from core code

## Setup

### Prerequisites

To run benchmarks that compare against implementations in the main repository, you need both repositories cloned side-by-side:

```bash
# Clone both repositories
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta.git
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git

# Ensure they are in the same parent directory
ls -la
# Should show:
# bigweaver-agent-canary-hydro-zeta/
# bigweaver-agent-canary-zeta-hydro-deps/
```

### Configuring Path Dependencies

Edit `timely-differential-benches/Cargo.toml` and uncomment the path dependencies:

```toml
# Uncomment these lines:
babyflow = { path = "../../bigweaver-agent-canary-hydro-zeta/babyflow" }
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = [ "debugging" ] }
hydroflow = { path = "../../bigweaver-agent-canary-hydro-zeta/hydroflow" }
spinachflow = { path = "../../bigweaver-agent-canary-hydro-zeta/spinachflow" }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

## Running Benchmarks

### Run All Benchmarks

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

### Run Specific Benchmarks

```bash
# Run a specific benchmark
cargo bench --bench arithmetic

# Run benchmarks matching a pattern
cargo bench fan

# Run with increased sample size
cargo bench --bench identity -- --sample-size 100
```

## Performance Comparison

These benchmarks compare multiple dataflow implementations:

- **timely-dataflow** - Low-latency data-parallel dataflow system
- **differential-dataflow** - Incremental computation based on timely-dataflow
- **babyflow** - Custom lightweight implementation
- **hydroflow** - DFIR-based dataflow implementation
- **spinachflow** - Alternative dataflow implementation

### Interpreting Results

Criterion will generate HTML reports in `target/criterion/`:

```bash
# View reports
open target/criterion/report/index.html
```

Each benchmark compares the throughput and latency across implementations.

## Benchmark Descriptions

### arithmetic.rs
Tests basic arithmetic operations in a dataflow pipeline.

### fan_in.rs
Measures performance of multiple streams merging into one (fan-in pattern).

### fan_out.rs
Measures performance of one stream splitting into multiple (fan-out pattern).

### fork_join.rs
Tests the fork-join pattern where work is split, processed in parallel, and rejoined.

### identity.rs
Baseline benchmark passing data through with minimal transformation.

### join.rs
Tests join operations between two streams.

### reachability.rs
Graph reachability using dataflow operators. Uses provided edge data files.

### upcase.rs
String processing benchmark converting strings to uppercase.

## Development

### Adding New Benchmarks

1. Create a new `.rs` file in `timely-differential-benches/benches/`
2. Add a `[[bench]]` entry to `timely-differential-benches/Cargo.toml`
3. Use the criterion harness pattern from existing benchmarks

### Updating Dependencies

Update versions in `timely-differential-benches/Cargo.toml`:
```bash
cd timely-differential-benches
cargo update
```

## Troubleshooting

### Path Dependencies Not Found

**Problem:** Cargo can't find babyflow, dfir_rs, etc.

**Solution:** Ensure:
1. Both repositories are cloned side-by-side
2. Path dependencies in Cargo.toml are uncommented
3. Paths match your directory structure

### Build Errors

**Problem:** Compilation fails with missing symbols or types.

**Solution:** The benchmarks may be out of sync with the main repository. Try:
```bash
cd ../bigweaver-agent-canary-hydro-zeta
git pull
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo clean
cargo bench
```

## Contributing

When adding new benchmarks:
1. Ensure they provide meaningful performance insights
2. Include baseline comparisons where relevant
3. Document the benchmark purpose and expected results
4. Update this README with benchmark descriptions

## License

Apache-2.0

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main repository with core implementations
