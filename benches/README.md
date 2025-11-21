# Timely and Differential Dataflow Benchmarks

Performance comparison benchmarks comparing Hydro/dfir_rs with Timely and Differential Dataflow.

These benchmarks have been separated from the main Hydro repository to isolate the timely and 
differential-dataflow dependencies while still allowing performance comparisons.

## Prerequisites

To run these benchmarks, you need:
1. This repository cloned
2. The main Hydro repository (bigweaver-agent-canary-hydro-zeta) must be accessible, as these
   benchmarks depend on `dfir_rs` and `sinktools` from that repository via git dependencies.

## Running Benchmarks

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
cargo bench -p benches --bench arithmetic
cargo bench -p benches --bench identity
```

## Benchmarks Included

- **arithmetic.rs** - Arithmetic operations pipeline comparison
- **fan_in.rs** - Fan-in pattern comparison
- **fan_out.rs** - Fan-out pattern comparison  
- **fork_join.rs** - Fork-join pattern comparison
- **identity.rs** - Identity/pass-through operation comparison
- **join.rs** - Join operation comparison
- **reachability.rs** - Graph reachability comparison with differential dataflow
- **upcase.rs** - String uppercase operation comparison

## Data Files

- `reachability_edges.txt` - Edge data for reachability benchmark
- `reachability_reachable.txt` - Expected reachable nodes for validation
- `words_alpha.txt` - Word list from https://github.com/dwyl/english-words/blob/master/words_alpha.txt

## Performance Comparison

These benchmarks allow direct performance comparison between:
- Hydro/dfir_rs implementations
- Timely Dataflow implementations
- Differential Dataflow implementations (where applicable)
- Raw/baseline implementations (channels, iterators, etc.)

The separated structure ensures that the main Hydro repository doesn't carry the timely/differential
dependencies while still maintaining the ability to perform comprehensive performance comparisons.
