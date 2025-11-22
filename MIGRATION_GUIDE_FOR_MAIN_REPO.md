# Migration Guide for Main Repository

This document should be added to the main `bigweaver-agent-canary-hydro-zeta` repository to inform users about the benchmark migration and how to access timely/differential benchmarks.

---

# Performance Benchmarks - Timely and Differential-Dataflow

## Important Notice: Benchmark Migration

The Timely Dataflow and Differential-Dataflow benchmarks have been moved to a separate repository to reduce dependency footprint and maintain cleaner separation of concerns.

### Where to Find Timely/Differential Benchmarks

**Repository**: [bigweaver-agent-canary-zeta-hydro-deps](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)

```bash
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
```

### What's in This Repository

This repository (`bigweaver-agent-canary-hydro-zeta`) contains:
- ✅ Hydroflow/DFIR benchmarks
- ✅ Core application code
- ✅ Baseline benchmarks (pipeline, iterator, raw)

### What's in the Deps Repository

The separate repository (`bigweaver-agent-canary-zeta-hydro-deps`) contains:
- ✅ Timely Dataflow benchmarks
- ✅ Differential-Dataflow benchmarks
- ✅ Performance comparison tools and guides

## Why the Change?

The benchmarks were separated to:

1. **Reduce Dependencies**: Remove timely and differential-dataflow from the main dependency tree
2. **Faster Builds**: Compile times improved for main repository
3. **Cleaner Architecture**: Clear separation between core functionality and external comparisons
4. **Independent Evolution**: Each framework can evolve independently

## Running Performance Comparisons

To compare Hydroflow/DFIR with Timely/Differential:

### Step 1: Run Hydroflow Benchmarks (This Repo)

```bash
cd bigweaver-agent-canary-hydro-zeta
cargo bench -p benches --save-baseline hydroflow
```

### Step 2: Run Timely/Differential Benchmarks (Deps Repo)

```bash
cd ../bigweaver-agent-canary-zeta-hydro-deps
cargo bench --save-baseline timely
```

### Step 3: Compare Results

Open the HTML reports from both repositories:

```bash
# Hydroflow results
open bigweaver-agent-canary-hydro-zeta/target/criterion/report/index.html

# Timely/Differential results
open bigweaver-agent-canary-zeta-hydro-deps/target/criterion/report/index.html
```

## Available Benchmarks

Comparable benchmarks exist in both repositories:

| Benchmark    | This Repo (Hydroflow) | Deps Repo (Timely/Differential) |
|--------------|:---------------------:|:-------------------------------:|
| identity     | ✅                    | ✅                              |
| arithmetic   | ✅                    | ✅                              |
| fan_in       | ✅                    | ✅                              |
| fan_out      | ✅                    | ✅                              |
| fork_join    | ✅                    | ✅                              |
| join         | ✅                    | ✅                              |
| upcase       | ✅                    | ✅                              |
| reachability | ✅                    | ✅ (Timely + Differential)      |

## Quick Start Guide

### For Hydroflow Development

No changes needed! Continue using this repository as before:

```bash
# Run Hydroflow benchmarks
cargo bench -p benches
```

### For Performance Comparison

1. **Clone both repositories**:
   ```bash
   git clone https://github.com/hydro-project/bigweaver-agent-canary-hydro-zeta.git
   git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
   ```

2. **Run benchmarks in both**:
   ```bash
   # Hydroflow
   cd bigweaver-agent-canary-hydro-zeta
   cargo bench -p benches
   
   # Timely/Differential
   cd ../bigweaver-agent-canary-zeta-hydro-deps
   cargo bench
   ```

3. **Compare results** using the HTML reports or comparison scripts

## Documentation

The deps repository includes comprehensive documentation:

- **README.md** - Overview and quick reference
- **GETTING_STARTED.md** - Detailed setup guide
- **PERFORMANCE_COMPARISON.md** - How to compare frameworks
- **RELATIONSHIP_TO_MAIN_REPO.md** - Architecture explanation

## FAQs

### Q: Why can't I find the timely benchmarks in this repo?

**A**: They were moved to a separate repository to keep dependencies lean. See the link above.

### Q: Can I still compare Hydroflow with Timely?

**A**: Yes! Clone both repositories and follow the comparison guide above.

### Q: Do I need the deps repo for normal development?

**A**: No. Only if you want to run performance comparisons with external frameworks.

### Q: Will the benchmarks stay synchronized?

**A**: The repositories use similar patterns and test data for fair comparison, but evolve independently.

### Q: How do I access the old benchmark code?

**A**: Check the git history of this repository, or use the new deps repository which has the extracted code.

## Migration Timeline

- **Before**: All benchmarks in this repository
- **Migration**: Timely/Differential extracted to separate repository
- **After**: Clean separation with maintained comparison capability

## Getting Help

For questions about:

- **Hydroflow benchmarks**: Open an issue in this repository
- **Timely/Differential benchmarks**: Open an issue in the deps repository
- **Comparison methodology**: See PERFORMANCE_COMPARISON.md in deps repository

## Links

- **Deps Repository**: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps
- **Timely Dataflow**: https://github.com/TimelyDataflow/timely-dataflow
- **Differential-Dataflow**: https://github.com/TimelyDataflow/differential-dataflow

---

*This document should be added to the main repository to help users find and use the migrated benchmarks.*
