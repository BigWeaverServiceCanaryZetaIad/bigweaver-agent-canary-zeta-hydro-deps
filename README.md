# Hydro Dependencies Repository

This repository contains code that depends on heavy external dependencies (such as timely-dataflow and differential-dataflow) that we don't want in the main Hydro repository.

## Contents

### Benchmarks (`benches/`)

Performance benchmarks comparing Hydro (DFIR) with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main `bigweaver-agent-canary-hydro-zeta` repository to:
- Avoid dependency pollution in the main codebase
- Retain the ability to run performance comparisons
- Keep the main repository lean and focused

See [`benches/README.md`](benches/README.md) for more information on running the benchmarks.

## Relationship to Main Repository

This repository works in conjunction with the main [bigweaver-agent-canary-hydro-zeta](https://github.com/hydro-project/hydro) repository. The benchmarks here reference dfir_rs and other Hydro packages from the main repository via git dependencies.

## Running Benchmarks

```bash
cd benches
cargo bench
```

See the [benches README](benches/README.md) for more details.