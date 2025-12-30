# Timely/Differential-Dataflow Benchmarks

This directory contains performance benchmarks for timely and differential-dataflow frameworks.

## Benchmark Descriptions

### Pure Timely/Differential Benchmarks

- **arithmetic.rs** - Tests arithmetic operations through a pipeline of map operations
- **fan_in.rs** - Tests merging multiple data streams into a single stream
- **fan_out.rs** - Tests distributing a single stream to multiple consumers  
- **fork_join.rs** - Tests splitting and merging dataflow patterns
- **identity.rs** - Tests identity operations through a pipeline
- **join.rs** - Tests hash join operations with various data types
- **reachability.rs** - Tests graph reachability algorithms using both timely and differential-dataflow
- **upcase.rs** - Tests string manipulation operations

## Running Benchmarks

All benchmarks use the [Criterion](https://github.com/bheisler/criterion.rs) framework for statistical benchmarking.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run a specific benchmark:
```bash
cargo bench -p benches --bench arithmetic
```

Run a specific benchmark function:
```bash
cargo bench -p benches --bench arithmetic -- arithmetic/timely
```

## Benchmark Results

Criterion generates detailed HTML reports in `target/criterion/` including:
- Statistical analysis of performance
- Comparison with previous runs
- Violin plots and other visualizations

## Data Files

Some benchmarks require data files located in this directory:
- `reachability_edges.txt` - Graph edges for reachability benchmark (532KB)
- `reachability_reachable.txt` - Expected reachable vertices (38KB)
- `words_alpha.txt` - English word list for string processing (3.8MB)

## Performance Comparison

These benchmarks can be compared with the hydroflow/dfir_rs implementations in the main repository at `../bigweaver-agent-canary-hydro-zeta/benches`. Both repositories contain versions of the same benchmarks testing their respective frameworks.
