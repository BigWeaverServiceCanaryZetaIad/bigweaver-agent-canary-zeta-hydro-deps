# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for the Hydro project that depend on external dataflow frameworks (Timely Dataflow and Differential Dataflow).

These benchmarks have been separated from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Reduce the dependency footprint of the main repository
- Maintain cleaner separation of concerns
- Enable focused performance comparisons between Hydro and other dataflow systems

## Contents

- `benches/` - Comparative benchmarks between Hydro and external frameworks

## Running Benchmarks

See [benches/README.md](benches/README.md) for detailed instructions on running benchmarks.