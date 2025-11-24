# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and dependencies that require the timely and differential-dataflow packages. These have been separated from the main bigweaver-agent-canary-hydro-zeta repository to maintain a cleaner dependency structure and reduce compilation complexity.

## Contents

- **benches/**: Benchmarks that use timely and differential-dataflow packages

## Purpose

The separation of these benchmarks serves several purposes:
- Avoids unnecessary dependencies in the main repository
- Maintains a cleaner overall project structure
- Improves maintainability by isolating different functional components
- Reduces compilation time for the main repository
- Retains the ability to run performance comparisons when needed

## Usage

To run the benchmarks:

```bash
cargo bench -p benches
```

For more information, see the [benches/README.md](benches/README.md).