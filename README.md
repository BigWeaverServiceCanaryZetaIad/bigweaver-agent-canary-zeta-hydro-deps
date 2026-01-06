# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks isolated from the main Hydro project to maintain clean dependency boundaries.

## Contents

### Benchmarks

Performance comparison benchmarks that depend on Timely Dataflow and Differential Dataflow packages. These benchmarks compare Hydro/DFIR performance against established dataflow frameworks.

See [benches/README.md](benches/README.md) for detailed information on running and understanding the benchmarks.

## Architecture

This repository follows the Hydro project's architectural principle of dependency isolation. By separating components that depend on Timely and Differential Dataflow into this dedicated repository, we:

- Prevent dependency bloat in the main Hydro repository
- Maintain clear boundaries between system components
- Enable independent development and versioning
- Simplify dependency management

## Usage

To run the benchmarks:

```bash
cargo bench -p benches
```

For more specific benchmark commands, see the [benches README](benches/README.md).