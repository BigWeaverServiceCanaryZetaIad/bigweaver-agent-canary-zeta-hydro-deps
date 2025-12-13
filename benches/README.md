# Microbenchmarks

Benchmarks comparing DFIR with timely-dataflow and differential-dataflow implementations.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench
```

Run specific benchmarks:
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench identity
```

Run with baseline comparison:
```bash
cargo bench -- --save-baseline my_baseline
cargo bench -- --baseline my_baseline
```

## Benchmark Descriptions

- **arithmetic** - Compares arithmetic operations across implementations
- **fan_in** - Tests merging multiple input streams
- **fan_out** - Tests splitting single stream to multiple outputs
- **fork_join** - Tests fork-join patterns
- **identity** - Tests passthrough/identity operations
- **join** - Tests join operations
- **micro_ops** - Micro-benchmarks for basic operations
- **reachability** - Graph reachability with real-world data
- **symmetric_hash_join** - Symmetric hash join operations
- **upcase** - String transformation operations
- **words_diamond** - Word processing patterns

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmarks
- `reachability_reachable.txt` - Reachability results for validation
- `words_alpha.txt` - Wordlist from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Results

Benchmark results are stored in `../target/criterion/` and include:
- HTML reports with charts
- Statistical analysis
- Baseline comparisons

Open `../target/criterion/report/index.html` in a browser to view results.
