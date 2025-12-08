# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) project.

## Contents

### Benchmarks

The `benches` directory contains microbenchmarks for timely and differential-dataflow, which were moved from the main repository to isolate heavy dependencies.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) - Main project repository