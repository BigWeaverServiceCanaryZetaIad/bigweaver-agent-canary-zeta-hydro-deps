# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks for timely and differential-dataflow that were moved from the main bigweaver-agent-canary-hydro-zeta repository to isolate heavy dependencies.

## Contents

### Benches

The `benches` directory contains performance benchmarks including:
- **join.rs**: Benchmarks comparing join operations between timely dataflow and a baseline implementation
- **reachability.rs**: Graph reachability benchmarks comparing timely, differential-dataflow, and dfir_rs implementations
- Additional benchmarks for various dataflow operations

## Running Benchmarks

To run the benchmarks, ensure the bigweaver-agent-canary-hydro-zeta repository is available at the sibling directory level, as the benchmarks reference dependencies from that repository.

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark
cargo bench --bench join
cargo bench --bench reachability
```

## Performance Comparisons

The benchmarks retain the ability to run performance comparisons across different implementations:
- Timely dataflow implementations
- Differential-dataflow implementations  
- Hydroflow (dfir_rs) implementations

This allows for comprehensive performance analysis and comparison between different dataflow frameworks.
