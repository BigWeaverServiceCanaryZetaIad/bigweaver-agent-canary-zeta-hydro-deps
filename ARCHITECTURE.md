# Architecture Documentation

This document explains the architectural design of the benchmark repository and its relationship with the main Hydro repository.

## Repository Relationships

```
┌─────────────────────────────────────────────────────────────┐
│                  Main Development Repository                 │
│         bigweaver-agent-canary-hydro-zeta                   │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────────┐      │
│  │   dfir_rs   │  │ sinktools   │  │ Other Crates │      │
│  │   (Hydro)   │  │             │  │              │      │
│  └─────────────┘  └─────────────┘  └──────────────┘      │
│         ▲               ▲                                  │
└─────────┼───────────────┼──────────────────────────────────┘
          │               │
          │ Path Dependencies
          │               │
┌─────────┼───────────────┼──────────────────────────────────┐
│         │               │                                  │
│  ┌──────┴───────────────┴─────┐                           │
│  │  benches/Cargo.toml        │                           │
│  │  (Benchmark Configuration)  │                           │
│  └────────────────────────────┘                           │
│              │                                             │
│              │ Defines                                     │
│              ▼                                             │
│  ┌─────────────────────────────────────┐                  │
│  │     Benchmark Implementations       │                  │
│  │                                     │                  │
│  │  ┌──────────┐  ┌────────────────┐  │                  │
│  │  │  Hydro   │  │    Timely      │  │                  │
│  │  │  (dfir)  │  │  (external)    │  │                  │
│  │  └──────────┘  └────────────────┘  │                  │
│  │                                     │                  │
│  │  ┌────────────────────────────────┐ │                  │
│  │  │   Differential-Dataflow        │ │                  │
│  │  │      (external)                │ │                  │
│  │  └────────────────────────────────┘ │                  │
│  └─────────────────────────────────────┘                  │
│                                                            │
│         bigweaver-agent-canary-zeta-hydro-deps            │
│              (Benchmark Repository)                        │
└────────────────────────────────────────────────────────────┘
```

## Dependency Flow

```
External Dependencies          Path Dependencies        Benchmark Code
┌──────────────────┐          ┌──────────────┐         ┌─────────────┐
│                  │          │              │         │             │
│  timely-master   │───┐      │   dfir_rs    │───┐     │  Hydro      │
│   (v0.13.0)      │   │      │   (Hydro)    │   │     │  impl       │
└──────────────────┘   │      └──────────────┘   │     └─────────────┘
                       │                          │            │
┌──────────────────┐   │      ┌──────────────┐   │            │
│                  │   ├─────▶│  benches/    │───┼───────────┤
│  differential-   │   │      │  Cargo.toml  │   │            │
│  dataflow-master │───┘      └──────────────┘   │     ┌─────────────┐
│   (v0.13.0)      │                              │     │  Timely     │
└──────────────────┘          ┌──────────────┐   └────▶│  impl       │
                              │  sinktools   │         └─────────────┘
┌──────────────────┐          │  (utils)     │                │
│                  │          └──────────────┘                │
│  criterion       │                                   ┌─────────────┐
│   (v0.5.0)       │──────────────────────────────────▶│ Differential│
└──────────────────┘                                   │  impl       │
                                                       └─────────────┘
                                                              │
                                                              ▼
                                                       Performance
                                                       Comparison
```

## Benchmark Execution Flow

```
1. User Command
   └─▶ ./run_benchmarks.sh reachability
       or
       cargo bench -p benches --bench reachability

2. Build Phase
   ├─▶ build.rs executes (if needed)
   │   └─▶ Generates fork_join_20.hf
   ├─▶ Resolve path dependencies
   │   ├─▶ dfir_rs from main repository
   │   └─▶ sinktools from main repository
   └─▶ Fetch external dependencies
       ├─▶ timely-master
       ├─▶ differential-dataflow-master
       └─▶ criterion

3. Execution Phase
   ├─▶ Setup test data
   ├─▶ Run Hydro implementation
   │   └─▶ Uses dfir_rs
   ├─▶ Run Timely implementation
   │   └─▶ Uses timely crate
   ├─▶ Run Differential implementation (if applicable)
   │   └─▶ Uses differential-dataflow crate
   └─▶ Compare results

4. Results Phase
   ├─▶ Terminal output
   │   └─▶ Timing comparisons
   ├─▶ Criterion reports
   │   ├─▶ target/criterion/<benchmark>/
   │   └─▶ HTML reports
   └─▶ Statistical analysis
```

## File Organization Architecture

```
Repository Root
├── Configuration Layer
│   ├── Cargo.toml (Workspace)
│   ├── rust-toolchain.toml
│   ├── clippy.toml
│   └── rustfmt.toml
│
├── Documentation Layer
│   ├── README.md (Overview)
│   ├── QUICKSTART.md (Getting Started)
│   ├── CONTRIBUTING.md (Development)
│   ├── MANIFEST.md (File Listing)
│   └── ARCHITECTURE.md (This file)
│
├── Tooling Layer
│   ├── run_benchmarks.sh (Execution)
│   └── compare_benchmarks.sh (Analysis)
│
└── Benchmark Layer
    └── benches/
        ├── Cargo.toml (Config)
        ├── build.rs (Generation)
        ├── README.md (Docs)
        └── benches/
            ├── *.rs (Implementations)
            └── *.txt (Test Data)
```

## Benchmark Implementation Architecture

Each benchmark follows a consistent pattern:

```
┌─────────────────────────────────────────────────────────┐
│                Benchmark File (e.g., arithmetic.rs)      │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Hydro Implementation Function                      │ │
│  │  ┌──────────────────────────────────────────────┐  │ │
│  │  │ fn hydro_arithmetic(c: &mut Criterion) {     │  │ │
│  │  │   c.bench_function("hydro/arithmetic", |b| { │  │ │
│  │  │     // Setup                                  │  │ │
│  │  │     // Run dfir_rs implementation           │  │ │
│  │  │     // Measure performance                   │  │ │
│  │  │   });                                         │  │ │
│  │  │ }                                             │  │ │
│  │  └──────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────┘ │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Timely Implementation Function                     │ │
│  │  ┌──────────────────────────────────────────────┐  │ │
│  │  │ fn timely_arithmetic(c: &mut Criterion) {    │  │ │
│  │  │   c.bench_function("timely/arithmetic", |b| {│  │ │
│  │  │     // Setup (same as Hydro)                 │  │ │
│  │  │     // Run timely implementation             │  │ │
│  │  │     // Measure performance                   │  │ │
│  │  │   });                                         │  │ │
│  │  │ }                                             │  │ │
│  │  └──────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────┘ │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Criterion Configuration                            │ │
│  │  criterion_group!(benches,                          │ │
│  │    hydro_arithmetic,                                │ │
│  │    timely_arithmetic);                              │ │
│  │  criterion_main!(benches);                          │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

## Data Flow Architecture

```
Input Data
    │
    ├─────────────────┬─────────────────┐
    │                 │                 │
    ▼                 ▼                 ▼
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Hydro   │    │ Timely   │    │Differential│
│  Pipeline│    │ Pipeline │    │ Pipeline  │
└──────────┘    └──────────┘    └──────────┘
    │                 │                 │
    │                 │                 │
    ▼                 ▼                 ▼
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Result  │    │  Result  │    │  Result  │
│   + Time │    │   + Time │    │   + Time │
└──────────┘    └──────────┘    └──────────┘
    │                 │                 │
    └─────────────────┴─────────────────┘
                      │
                      ▼
              ┌───────────────┐
              │   Criterion   │
              │  Statistical  │
              │   Analysis    │
              └───────────────┘
                      │
         ┌────────────┴────────────┐
         │                         │
         ▼                         ▼
    ┌─────────┐              ┌─────────┐
    │Terminal │              │  HTML   │
    │ Output  │              │ Reports │
    └─────────┘              └─────────┘
```

## Module Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│                     Benchmark Module                         │
│                                                             │
│  uses: criterion, dfir_rs, sinktools                        │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  arithmetic │  │   fan_in    │  │   fan_out   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  fork_join  │  │  identity   │  │    join     │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                             │
│  uses: timely                                               │
│                                                             │
│  ┌─────────────────────────────────────────┐               │
│  │           reachability                  │               │
│  └─────────────────────────────────────────┘               │
│                                                             │
│  uses: differential-dataflow                                │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   futures   │  │  micro_ops  │  │sym_hash_join│        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                             │
│  ┌─────────────┐                                           │
│  │words_diamond│                                           │
│  └─────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
```

## Build Architecture

```
Build Invocation (cargo bench)
        │
        ▼
┌───────────────┐
│  build.rs     │
│  Executes     │
└───────────────┘
        │
        ▼
┌───────────────────────────────┐
│  Generates fork_join_20.hf    │
│  (Hydro macro code)           │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│  Compile Dependencies         │
│  ├─ dfir_rs (from main repo) │
│  ├─ sinktools (from main)    │
│  ├─ timely (external)        │
│  ├─ differential (external)  │
│  └─ criterion (external)     │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│  Compile Benchmarks           │
│  (All 12 benchmark files)     │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│  Link & Produce Binary        │
└───────────────────────────────┘
        │
        ▼
┌───────────────────────────────┐
│  Execute Benchmarks           │
└───────────────────────────────┘
```

## Design Principles

### 1. Separation of Concerns
- **Main Repository**: Core Hydro functionality
- **Benchmark Repository**: Performance comparisons with external dependencies
- **Clear Boundaries**: Path dependencies clearly defined

### 2. Modularity
- Each benchmark is independent
- Shared configuration at workspace level
- Common patterns across implementations

### 3. Maintainability
- Comprehensive documentation
- Helper scripts for common tasks
- Clear file organization
- Consistent naming conventions

### 4. Performance Isolation
- Benchmarks don't affect main repository build times
- External dependencies isolated
- Parallel execution where possible

### 5. Reproducibility
- Fixed dependency versions
- Deterministic builds
- Version-controlled test data
- Documented methodology

## Security Considerations

### Dependency Management
- External dependencies specified with exact versions
- Path dependencies ensure local code is used
- No network access during benchmark execution

### Data Handling
- Test data committed to repository
- No external data sources at runtime
- Reproducible inputs

## Performance Characteristics

### Compilation
- Benchmark compilation is isolated from main repository
- Build caching enabled via Cargo
- Incremental compilation supported

### Execution
- Criterion handles statistical rigor
- Warm-up iterations automatic
- Multiple samples for accuracy
- Outlier detection and removal

### Scaling
- Benchmarks can be run individually or in parallel
- Resource usage monitored
- Timeout protection (can be configured)

## Future Architecture Considerations

### Potential Enhancements
1. **CI Integration**: Automated benchmark runs on commits
2. **Result Archiving**: Historical performance data storage
3. **Regression Detection**: Automatic performance regression alerts
4. **Distributed Benchmarking**: Run across multiple machines
5. **Custom Reporters**: Additional output formats

### Extensibility Points
- New benchmarks: Add to benches/benches/
- New dependencies: Add to benches/Cargo.toml
- New comparisons: Follow existing patterns
- New tooling: Add scripts to root

## Constraints and Limitations

### Current Constraints
1. Requires both repositories checked out as siblings
2. Path dependencies are relative
3. Rust toolchain version must match
4. Some benchmarks require large data files

### Known Limitations
1. No cross-platform benchmarking comparison
2. Results vary by hardware
3. No real-time streaming benchmarks
4. Limited to Rust implementations

## Summary

This architecture provides:
- ✅ Clear separation between main and benchmark code
- ✅ Maintainable and extensible structure
- ✅ Comprehensive tooling and documentation
- ✅ Performance comparison capabilities
- ✅ Reproducible and reliable benchmarking

The design follows team best practices for:
- Modular organization
- Dependency management
- Documentation standards
- Testing methodology
- Performance evaluation
