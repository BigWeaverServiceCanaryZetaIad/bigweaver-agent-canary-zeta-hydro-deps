# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely-dataflow and differential-dataflow. These components were separated from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to:

1. Reduce unnecessary dependencies in the main repository
2. Maintain clean separation of concerns
3. Keep the main repository focused on core functionality
4. Enable independent evolution of benchmarking infrastructure

## Contents

### Benchmarks (`benches/`)

Performance benchmarks that use timely-dataflow and differential-dataflow. These benchmarks allow for performance comparisons between DFIR implementations and timely/differential implementations.

See [benches/README.md](benches/README.md) for details on running benchmarks and comparing results.

## Usage

### Running Benchmarks

```bash
cd benches
cargo bench
```

### Performance Comparisons

Performance comparisons with the main repository can be performed by running benchmarks in both repositories and comparing the criterion HTML reports in `target/criterion/` directories.

## Relationship to Main Repository

This repository complements the main bigweaver-agent-canary-hydro-zeta repository by providing:
- Performance benchmarks using timely and differential-dataflow
- Reference implementations for comparison purposes
- Historical performance data through criterion reports

The main repository contains the core DFIR-based benchmarks that do not require these heavier dependencies.