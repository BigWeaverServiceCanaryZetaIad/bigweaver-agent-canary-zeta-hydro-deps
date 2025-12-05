# Usage Guide

## Quick Start

### Clone the Repository

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps
```

### Run Benchmarks

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Run benchmark with filter
cargo bench -p benches --bench reachability -- "dfir"
```

## Using Local Dependencies (Optional)

If you have the main Hydro repository cloned locally, you can use path dependencies for faster builds:

1. Edit `benches/Cargo.toml`
2. Replace the git dependencies with path dependencies:

```toml
[dev-dependencies]
# ... other deps ...
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
# ... rest of deps ...
```

3. Adjust the paths based on your directory structure.

## Viewing Results

After running benchmarks, view the HTML reports:

```bash
# On macOS
open target/criterion/report/index.html

# On Linux
xdg-open target/criterion/report/index.html

# On Windows
start target/criterion/report/index.html
```

## Available Benchmarks

### Basic Operations
- `cargo bench -p benches --bench identity` - Identity transformations
- `cargo bench -p benches --bench arithmetic` - Arithmetic operations
- `cargo bench -p benches --bench upcase` - String transformations

### Dataflow Patterns
- `cargo bench -p benches --bench fan_in` - Fan-in patterns
- `cargo bench -p benches --bench fan_out` - Fan-out patterns
- `cargo bench -p benches --bench fork_join` - Fork-join patterns
- `cargo bench -p benches --bench words_diamond` - Diamond patterns

### Join Operations
- `cargo bench -p benches --bench join` - Standard joins
- `cargo bench -p benches --bench symmetric_hash_join` - Symmetric hash joins

### Advanced
- `cargo bench -p benches --bench reachability` - Graph reachability (uses differential-dataflow)
- `cargo bench -p benches --bench micro_ops` - Fine-grained operation benchmarks
- `cargo bench -p benches --bench futures` - Async/await patterns

## Comparing Implementations

Each benchmark typically compares three implementations:
1. **DFIR** - Hydro's dataflow IR
2. **Timely** - TimelySataflow implementation
3. **Differential** - Differential-dataflow (where applicable)

Example output:
```
reachability/dfir_rs    time: [123.45 ms 125.67 ms 127.89 ms]
reachability/timely     time: [145.67 ms 147.89 ms 150.12 ms]
reachability/differential time: [134.56 ms 136.78 ms 138.90 ms]
```

## Filtering Benchmarks

Run only specific implementations:

```bash
# Run only DFIR benchmarks
cargo bench -p benches -- "dfir"

# Run only timely benchmarks
cargo bench -p benches -- "timely"

# Run only differential benchmarks
cargo bench -p benches -- "differential"
```

## Benchmarking Tips

### For Accurate Results

1. **Close unnecessary applications** to reduce system noise
2. **Disable frequency scaling** (if possible):
   ```bash
   # On Linux (may require sudo)
   echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   ```
3. **Run multiple iterations**: Criterion does this automatically
4. **Avoid thermal throttling**: Ensure adequate cooling
5. **Use a quiet system**: Minimize background tasks

### Benchmark Duration

- Individual benchmarks: 5-60 seconds each
- Full suite: 10-30 minutes
- Large benchmarks (reachability): May take several minutes

### Customizing Benchmark Parameters

Some benchmarks have configurable parameters at the top of their source files:

```rust
const NUM_INTS: usize = 1_000_000;  // Adjust data size
const NUM_OPS: usize = 20;           // Adjust operation count
```

Edit the benchmark files and re-run to test different scales.

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update Rust**: `rustup update`
2. **Clean build**: `cargo clean`
3. **Check dependencies**: Ensure git dependencies are accessible

### Out of Memory

For large benchmarks:
- Reduce `NUM_INTS` or similar constants
- Run benchmarks individually rather than the full suite
- Increase system swap space

### Slow Compilation

- Use path dependencies for local development (see above)
- Enable incremental compilation (usually automatic)
- Use `cargo bench --no-run` to compile without running

## Contributing

To add new benchmarks:

1. Create a new file in `benches/benches/`
2. Add a `[[bench]]` entry in `benches/Cargo.toml`
3. Follow the existing pattern with DFIR, Timely, and Differential implementations
4. Update BENCHMARKS.md with details
5. Submit a pull request

## Questions or Issues?

- **Main Hydro Project**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- **Documentation**: https://hydro.run/docs
- **Migration Guide**: See BENCHMARK_MIGRATION.md in the main repository
