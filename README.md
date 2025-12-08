# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow packages. These dependencies have been isolated from the main bigweaver-agent-canary-hydro-zeta repository to keep the main repository lean and focused.

## Contents

- **benches**: Performance benchmarks for timely and differential-dataflow implementations

## Usage

To run benchmarks:

```bash
cd benches
cargo bench
```

For more information about the benchmarks, see the [benches README](benches/README.md).