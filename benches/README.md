# Microbenchmarks

Of Hydro and other crates (timely-dataflow, differential-dataflow).

## Setup

These benchmarks reference the main Hydro repository for `dfir_rs` and `sinktools`. You have two options:

### Option 1: Use Git Dependencies (Default)
The benchmarks are configured to fetch dependencies from the main repository via git. This works out of the box but may be slower to build.

### Option 2: Use Local Path Dependencies (Recommended for Development)
If you have both repositories cloned locally, update `Cargo.toml` to use path dependencies:

```toml
dfir_rs = { path = "../../bigweaver-agent-canary-hydro-zeta/dfir_rs", features = ["debugging"] }
sinktools = { path = "../../bigweaver-agent-canary-hydro-zeta/sinktools", version = "^0.0.1" }
```

Adjust the paths based on your local directory structure.

## Running Benchmarks

Run all benchmarks:
```
cargo bench -p benches
```

Run specific benchmarks:
```
cargo bench -p benches --bench reachability
cargo bench -p benches --bench micro_ops
cargo bench -p benches --bench join
```

## Benchmark Results

Results are saved to `target/criterion/` with HTML reports. Open `target/criterion/report/index.html` in your browser to view detailed results.

## Data Files

Wordlist is from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
