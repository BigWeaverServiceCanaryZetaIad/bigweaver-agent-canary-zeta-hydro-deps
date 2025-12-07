# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner codebase and prevent dependency bloat.

## Contents

### Benchmarks

The `benches/` directory contains performance benchmarks that depend on timely and differential-dataflow packages. These benchmarks have been moved here to avoid including these dependencies in the main repository.

See [benches/README.md](benches/README.md) for more information on running and using these benchmarks.

## Performance Comparisons

The benchmarks in this repository can be compared with benchmarks in the main bigweaver-agent-canary-hydro-zeta repository to evaluate performance differences between different implementations.