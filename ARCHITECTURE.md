# Repository Architecture

## Overview

This document describes the architectural relationship between the main Hydro repository and this benchmark dependencies repository.

## Repository Structure

```
BigWeaver Canary Zeta IAD Project
│
├── bigweaver-agent-canary-hydro-zeta/          [Main Repository]
│   │
│   ├── Core Framework
│   │   ├── dfir_rs/                 # DFIR runtime
│   │   ├── hydro_lang/              # Hydro language
│   │   ├── hydro_std/               # Standard library
│   │   └── ...                      # Other core modules
│   │
│   ├── Built-in Benchmarks
│   │   ├── hydro_test/
│   │   │   └── cluster/
│   │   │       ├── paxos_bench.rs   # Uses standard tools
│   │   │       └── two_pc_bench.rs  # Uses standard tools
│   │   ├── dfir_rs/examples/kvs_bench/  # Criterion benchmarks
│   │   └── hydro_std/bench_client/      # Benchmark infrastructure
│   │
│   └── Documentation
│       ├── README.md
│       └── BENCHMARK_MIGRATION.md   # How to work across repos
│
└── bigweaver-agent-canary-zeta-hydro-deps/    [This Repository]
    │
    ├── Benchmark Infrastructure
    │   ├── Cargo.toml               # Workspace config
    │   ├── .github/workflows/       # CI/CD
    │   └── benchmarks/              # Benchmark crates
    │
    ├── Documentation
    │   ├── README.md                # Overview
    │   ├── BENCHMARKS.md            # Detailed guide
    │   ├── CONTRIBUTING.md          # Developer guide
    │   ├── QUICKSTART.md            # Quick reference
    │   └── ARCHITECTURE.md          # This file
    │
    └── Tools
        ├── run_benchmarks.sh        # Benchmark runner
        └── compare_with_main_repo.sh # Cross-repo comparison
```

## Design Principles

### Separation of Concerns

```
┌─────────────────────────────────────┐
│   Main Repository                   │
│                                     │
│  • Production code                  │
│  • Core functionality               │
│  • Standard benchmarks              │
│  • Fast builds                      │
│  • Minimal dependencies             │
└─────────────────────────────────────┘
           │
           │ References for
           │ comparison
           ▼
┌─────────────────────────────────────┐
│   Deps Repository (This)            │
│                                     │
│  • Specialized benchmarks           │
│  • Heavy dependencies               │
│  • Timely/Differential-dataflow     │
│  • Performance analysis             │
│  • Independent builds               │
└─────────────────────────────────────┘
```

### Dependency Flow

```
Main Repository Dependencies:
┌────────────┐
│   dfir_rs  │
└─────┬──────┘
      │
      ├─► criterion (dev-dependency only)
      ├─► tokio
      ├─► serde
      └─► lattices
      
      ❌ No timely
      ❌ No differential-dataflow

Deps Repository Dependencies:
┌──────────────┐
│ my_benchmark │
└──────┬───────┘
       │
       ├─► timely              ✅ Allowed here
       ├─► differential-dataflow ✅ Allowed here
       ├─► criterion
       └─► [references to main repo crates if needed]
```

## Benchmark Categories

### Category 1: Standard Benchmarks (Main Repository)

**Characteristics:**
- Use criterion or standard testing
- Test core functionality
- No heavy dependencies
- Fast to build and run
- Part of regular development cycle

**Examples:**
- Paxos consensus performance
- Two-phase commit benchmarks
- KVS operations
- Basic dataflow operations

**Location:** `bigweaver-agent-canary-hydro-zeta/`

### Category 2: Specialized Benchmarks (Deps Repository)

**Characteristics:**
- Require timely/differential-dataflow
- Complex dataflow operations
- Integration with external systems
- Slower builds (worth the isolation)
- Run less frequently

**Examples (When Created):**
- Complex differential dataflow operations
- Timely dataflow comparisons
- Integration benchmarks
- Cross-system performance tests

**Location:** `bigweaver-agent-canary-zeta-hydro-deps/`

## Workflow Patterns

### Pattern 1: Standard Development

```
Developer working on core feature
              │
              ▼
┌─────────────────────────┐
│  Main Repository        │
│                         │
│  1. Edit code           │
│  2. cargo build         │ ← Fast (no heavy deps)
│  3. cargo test          │
│  4. cargo bench         │
│  5. Commit              │
└─────────────────────────┘
```

### Pattern 2: Performance Analysis

```
Developer investigating performance
              │
              ├─────────────────────┐
              ▼                     ▼
┌──────────────────────┐  ┌──────────────────────┐
│  Main Repository     │  │  Deps Repository     │
│                      │  │                      │
│  Run standard        │  │  Run specialized     │
│  benchmarks          │  │  benchmarks          │
└──────────────────────┘  └──────────────────────┘
              │                     │
              └──────────┬──────────┘
                         ▼
              Compare results using
              compare_with_main_repo.sh
```

### Pattern 3: Benchmark Migration

```
Benchmark becomes too heavy for main repo
              │
              ▼
┌─────────────────────────────────────┐
│  1. Copy benchmark to deps repo     │
│  2. Add timely/differential deps    │
│  3. Update workspace                │
│  4. Test in deps repo               │
│  5. Update documentation            │
│  6. (Optional) Remove from main     │
└─────────────────────────────────────┘
```

## Build Time Comparison

### Without Separation (Old Approach)

```
Main Repository with heavy deps:
├── Core code changes: 30s
├── Heavy benchmark deps: 180s  ← Problem!
└── Total: 210s for every build
```

### With Separation (Current Approach)

```
Main Repository (light):
├── Core code changes: 30s
└── Total: 30s ✅ 7x faster!

Deps Repository (when needed):
├── Benchmark changes: 45s
├── Heavy deps: 180s
└── Total: 225s (but isolated, run less often)
```

## Communication Between Repositories

### No Direct Dependencies

The repositories are **independent**:
- No circular dependencies
- Main repo doesn't depend on deps repo
- Deps repo may reference main repo types (optional)

### Comparison Mechanism

```
┌────────────────┐         ┌────────────────┐
│  Main Repo     │         │  Deps Repo     │
│                │         │                │
│  Benchmarks    │         │  Benchmarks    │
│      │         │         │      │         │
│      ▼         │         │      ▼         │
│  Results       │         │  Results       │
└──────┬─────────┘         └──────┬─────────┘
       │                          │
       └──────────┬───────────────┘
                  ▼
         ┌────────────────┐
         │ Comparison     │
         │ Scripts        │
         │                │
         │ • Collect      │
         │ • Analyze      │
         │ • Report       │
         └────────────────┘
```

## Continuous Integration

### Main Repository CI

```
┌─────────────────────────┐
│  Main Repo CI           │
│                         │
│  ✓ Build core           │
│  ✓ Run tests            │
│  ✓ Run std benchmarks   │
│  ✓ Deploy               │
│                         │
│  Duration: ~5 minutes   │
└─────────────────────────┘
```

### Deps Repository CI

```
┌─────────────────────────┐
│  Deps Repo CI           │
│                         │
│  ✓ Build benchmarks     │
│  ✓ Run benchmarks       │
│  ✓ Compare with PR base │
│  ✓ Upload artifacts     │
│                         │
│  Duration: ~15 minutes  │
│  (OK - runs less often) │
└─────────────────────────┘
```

## Future Extensions

### Possible Additions

1. **Benchmark Result Database**
   - Store historical results
   - Track performance trends
   - Alert on regressions

2. **Automated Comparison Reports**
   - Scheduled cross-repo benchmarks
   - Generate comparison dashboards
   - Email performance summaries

3. **More Benchmark Categories**
   - `benchmarks/dataflow_benchmarks/`
   - `benchmarks/integration_benchmarks/`
   - `benchmarks/stress_tests/`

4. **Shared Benchmark Library**
   - Common benchmark utilities
   - Shared test data generators
   - Reusable benchmark components

## Benefits Summary

### For Developers
- ✅ Faster builds in main repo
- ✅ Clear separation of concerns
- ✅ Easy to find benchmarks
- ✅ Comprehensive documentation

### For CI/CD
- ✅ Faster main repo pipeline
- ✅ Isolated benchmark testing
- ✅ Independent deployment
- ✅ Parallel execution possible

### For Maintenance
- ✅ Less technical debt in main repo
- ✅ Easier to update dependencies
- ✅ Clear ownership
- ✅ Better organization

### For Performance Testing
- ✅ Preserved comparison capability
- ✅ More specialized testing possible
- ✅ Better tool availability
- ✅ Comprehensive benchmarks

## References

- Main Repository: `../bigweaver-agent-canary-hydro-zeta`
- Benchmark Guide: [BENCHMARKS.md](BENCHMARKS.md)
- Migration Guide: [../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md)
- Quick Start: [QUICKSTART.md](QUICKSTART.md)
- Contributing: [CONTRIBUTING.md](CONTRIBUTING.md)
