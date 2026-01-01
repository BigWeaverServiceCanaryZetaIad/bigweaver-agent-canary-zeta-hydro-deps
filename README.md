# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the bigweaver-agent-canary-hydro-zeta project.

## Contents

### benches

The `benches` directory contains microbenchmarks comparing DFIR with other dataflow frameworks:

- **fan_in.rs** - Benchmark comparing DFIR with Timely for fan-in operations
- **fan_out.rs** - Benchmark comparing DFIR with Timely for fan-out operations  
- **reachability.rs** - Benchmark comparing DFIR with Differential Dataflow for graph reachability
- **join.rs** - Benchmark for join operations
- Additional benchmarks for micro-operations, arithmetic, identity, and more

These benchmarks depend on:
- `timely-master` - Timely Dataflow framework
- `differential-dataflow-master` - Differential Dataflow framework
- `dfir_rs` - The main DFIR runtime (from bigweaver-agent-canary-hydro-zeta)

## Running Benchmarks

To run the benchmarks, ensure both repositories are checked out as siblings:

```
/projects/sandbox/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/
```

Then run:

```bash
cd bigweaver-agent-canary-zeta-hydro-deps
cargo bench
```

Or run specific benchmarks:

```bash
cargo bench -- reachability
cargo bench -- fan_in
cargo bench -- fan_out
```