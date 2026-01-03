# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks that compare Hydro with external dataflow frameworks including Timely Dataflow and Differential Dataflow.

## Structure

- `benches/` - Performance benchmarks comparing Hydro with Timely and Differential Dataflow

## Running Benchmarks

```bash
cargo bench -p benches
```

To run a specific benchmark:

```bash
cargo bench -p benches --bench reachability
```

## Dependencies

The benchmarks in this repository depend on:
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
- `dfir_rs` - Hydro's DFIR implementation (from main repository)
- `sinktools` - Hydro's sink utilities (from main repository)