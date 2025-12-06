# Hydro Dependencies Repository

This repository contains dependencies and benchmarks that have been separated from the main Hydro repository.

## Contents

### Benchmarks

The `benches` directory contains benchmarks that depend on timely and differential-dataflow. These benchmarks were moved here to avoid including these dependencies in the main Hydro repository.

See [benches/README.md](benches/README.md) for more information on running benchmarks.

## Purpose

This repository serves to:
- House benchmarks requiring timely and differential-dataflow dependencies
- Maintain the ability to run performance comparisons without bloating the main repository
- Keep the main Hydro repository focused on core functionality

## Related Repositories

- Main Hydro repository: Contains core Hydro functionality and benchmarks without external dataflow dependencies