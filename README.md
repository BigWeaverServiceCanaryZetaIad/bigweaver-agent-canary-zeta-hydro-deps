# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks for the Hydro project that require external dependencies like `timely-dataflow` and `differential-dataflow`. These have been separated from the main repository to keep it lean and focused.

## Contents

### Benches

Microbenchmarks for Hydro that compare performance with timely-dataflow and differential-dataflow implementations.

Run all benchmarks:
```bash
cargo bench -p benches
```

Run specific benchmarks:
```bash
cargo bench -p benches --bench reachability
```

## Performance Comparisons

These benchmarks allow comparing Hydro's performance against timely-dataflow and differential-dataflow. The benchmarks reference the main Hydro repository as a git dependency to ensure they test against the latest code.

## Related Repositories

- Main Hydro repository: https://github.com/hydro-project/hydro