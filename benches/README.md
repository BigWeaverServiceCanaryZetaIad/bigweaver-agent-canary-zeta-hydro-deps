# Performance Benchmarks

## Overview

This directory contains performance benchmarks comparing dfir_rs with timely and differential-dataflow implementations. These benchmarks were moved from the main repository to maintain clean separation between core functionality and external framework comparisons.

## Quick Start

### Run All Benchmarks
```bash
cargo bench
```

### Run Specific Benchmark
```bash
cargo bench --bench reachability
cargo bench --bench arithmetic
cargo bench --bench identity
```

### Run with Filter
```bash
# Run only tests matching a pattern
cargo bench --bench arithmetic -- pipeline
```

## Available Benchmarks

| Benchmark | Description | Dependencies |
|-----------|-------------|--------------|
| arithmetic | Arithmetic operations comparison | timely |
| fan_in | Fan-in pattern tests | timely |
| fan_out | Fan-out pattern tests | timely |
| fork_join | Fork-join concurrency | timely |
| identity | Identity operations baseline | timely |
| join | Join operations | timely |
| reachability | Graph reachability algorithms | timely, differential |
| upcase | String transformations | timely |

## Test Data

### reachability_edges.txt (524KB)
Graph edge data for reachability benchmarks.

### reachability_reachable.txt (40KB)
Expected reachability results for verification.

### words_alpha.txt (3.7MB)
English word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt
Used for text processing benchmarks.

## Dependencies

This package requires:
- **Rust toolchain** - See rust-toolchain.toml in main repository
- **timely-master** (0.13.0-dev.1) - Timely dataflow framework
- **differential-dataflow-master** (0.13.0-dev.1) - Differential dataflow framework
- **dfir_rs** - From bigweaver-agent-canary-hydro-zeta repository
- **sinktools** - From bigweaver-agent-canary-hydro-zeta repository

## Directory Structure

Expected repository layout:
```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/    # Main repository
│   ├── dfir_rs/
│   ├── sinktools/
│   └── ...
└── bigweaver-agent-canary-zeta-hydro-deps/  # This repository
    └── benches/                           # This directory
        ├── Cargo.toml
        ├── build.rs
        └── benches/
            ├── *.rs                       # Benchmark files
            └── *.txt                      # Test data
```

## Viewing Results

### Console Output
Results are displayed immediately after running.

### HTML Reports
Detailed reports are generated in `target/criterion/`:
```bash
open target/criterion/report/index.html
```

## Performance Comparison

To compare with dfir_rs benchmarks:

```bash
# From main repository
cd ../../bigweaver-agent-canary-hydro-zeta/benches
cargo bench -- --save-baseline dfir_rs

# From this repository
cd ../../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo bench -- --save-baseline external

# Compare results in HTML reports or use comparison script
cd ..
./run_comparison.sh
```

## Troubleshooting

### "Cannot find dfir_rs"
Ensure the main repository is cloned at the correct relative path:
```bash
ls ../../bigweaver-agent-canary-hydro-zeta/dfir_rs
```

### Build Errors
Try cleaning and rebuilding:
```bash
cargo clean
cargo build --release --benches
```

### Inconsistent Results
- Close background applications
- Run with more samples: `cargo bench -- --sample-size 200`
- Check system load with `htop`

## More Information

- **Detailed documentation**: See ../BENCHMARKS.md
- **Quick start guide**: See ../QUICKSTART.md
- **Main repository docs**: See ../../bigweaver-agent-canary-hydro-zeta/
- **Verification**: Run `../verify_benchmarks.sh`

## Contributing

See ../CONTRIBUTING.md for guidelines on adding new benchmarks.
