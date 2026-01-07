# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies for Timely Dataflow and Differential Dataflow that were separated from the main Hydro project to isolate these external dependencies.

## Contents

### Benchmarks (`/benches`)

Performance comparison benchmarks between Hydro/DFIR and Timely/Differential Dataflow implementations. These benchmarks enable:

- Performance tracking across different dataflow systems
- Regression detection
- Comparative analysis between frameworks

See [benches/README.md](benches/README.md) for more details on running benchmarks.

## Moved from bigweaver-agent-canary-hydro-zeta

This repository was created to separate timely and differential-dataflow dependencies from the main Hydro repository. The benchmarks maintain the same functionality and performance comparison capabilities as before.