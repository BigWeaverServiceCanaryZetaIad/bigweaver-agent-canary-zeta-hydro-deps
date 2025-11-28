# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. These components were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

- Maintain clean separation of concerns
- Reduce technical debt in the main repository
- Avoid introducing unnecessary dependencies in the core codebase
- Enable independent performance testing and comparison

## Contents

- **benches/**: Microbenchmarks for timely and differential-dataflow operations

## Usage

See the [benches README](benches/README.md) for detailed information on running benchmarks and performance comparisons.

## Related Repositories

- [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta): Main repository