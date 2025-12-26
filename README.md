# bigweaver-agent-canary-zeta-hydro-deps

This repository contains dependencies and benchmarks that have been isolated from the main bigweaver-agent-canary-hydro-zeta repository to maintain clean dependency management and prevent technical debt accumulation.

## Contents

### timely-benchmarks

Contains benchmarks that depend on timely and differential-dataflow packages. These benchmarks were moved from the main repository to avoid including direct dependencies on these packages in the main codebase.

See [timely-benchmarks/README.md](timely-benchmarks/README.md) for more details on running and using these benchmarks.

## Purpose

The separation of these benchmarks serves several key purposes:

1. **Dependency Isolation**: Prevents direct dependencies on timely and differential-dataflow in the main repository
2. **Technical Debt Prevention**: Keeps the main repository's dependency graph clean and manageable
3. **Performance Comparison**: Retains the ability to run performance comparisons between different dataflow implementations
4. **Modular Architecture**: Supports a microservice/component separation approach

## Migration

These benchmarks were migrated from the bigweaver-agent-canary-hydro-zeta repository. For details on the migration process, see the BENCHMARK_MIGRATION.md file in the main repository.