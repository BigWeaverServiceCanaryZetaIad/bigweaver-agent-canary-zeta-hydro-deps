# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely and differential-dataflow libraries. These components were moved from the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to keep the main repository free of these heavy dependencies.

## Contents

- `benches/` - Performance benchmarks using timely and differential-dataflow

## Purpose

By isolating timely and differential-dataflow dependencies in this separate repository, we:
- Reduce the dependency footprint of the main hydro repository
- Speed up builds for developers who don't need these benchmarks
- Maintain the ability to run performance comparisons and benchmarks against these frameworks
- Keep the codebase modular and well-organized

## Setup

These benchmarks reference code from the main hydro repository. Ensure you have both repositories cloned at the same level:

```
parent-directory/
├── bigweaver-agent-canary-hydro-zeta/
└── bigweaver-agent-canary-zeta-hydro-deps/  (this repository)
```

## Quick Start

```bash
cd benches
cargo bench
```

For more details, see the [benches/README.md](benches/README.md).