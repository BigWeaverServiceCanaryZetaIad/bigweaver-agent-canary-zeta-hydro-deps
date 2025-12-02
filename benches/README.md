# Microbenchmarks

Performance benchmarks for Hydro comparing implementations with timely and differential-dataflow.

## Quick Start

Run all benchmarks:
```bash
cargo bench -p benches
```

Or use the convenience script:
```bash
../run_benchmarks.sh --all
```

## Run Specific Benchmarks

```bash
# Using cargo directly
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic

# Using the convenience script
../run_benchmarks.sh --bench reachability
```

## List Available Benchmarks

```bash
../run_benchmarks.sh --list
```

## Performance Comparisons

Save current run as baseline:
```bash
../run_benchmarks.sh --all --baseline before-optimization
```

Compare against baseline:
```bash
# Make changes to Hydro code, then:
../run_benchmarks.sh --all --compare before-optimization
```

## Benchmark Results

Results are generated as HTML reports in:
```
target/criterion/<benchmark_name>/report/index.html
```

Open these files in your browser to see detailed performance metrics including:
- Throughput measurements
- Latency distributions
- Performance trends over time
- Statistical analysis

## Notes

- Wordlist data is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
- Graph data for reachability benchmarks is included in test data files
