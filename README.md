# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on heavy external dependencies like Timely Dataflow and Differential Dataflow.

## Contents

### Benches

Performance benchmarks comparing Hydro with Timely Dataflow and Differential Dataflow implementations.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

See [benches/README.md](benches/README.md) for more details.

## Purpose

This repository was created to separate heavy dependencies (timely-master, differential-dataflow-master) from the main Hydro repository, improving build times and reducing dependency bloat in the core project.