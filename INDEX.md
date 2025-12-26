# Documentation Index

This repository contains comprehensive benchmarks comparing Hydro, Timely, and Differential Dataflow implementations. Use this index to find the right documentation for your needs.

## Quick Navigation

### 🚀 Just Want to Run Benchmarks?
**→ [QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Copy-paste commands to run benchmarks

### 📚 Want to Learn About the Benchmarks?
**→ [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md)** - Complete guide with examples and explanations

### 📊 Want to See What's Available?
**→ [README.md](README.md)** - Overview of all benchmarks and their implementations

### 🔍 Want to Know What Changed?
**→ [CHANGES.md](CHANGES.md)** - Recent additions and implementation details

### 📝 Want the Full Story?
**→ [MIGRATION.md](MIGRATION.md)** - History of how benchmarks were migrated and enhanced

## Document Purposes

### Getting Started
| Document | Purpose | Audience | Length |
|----------|---------|----------|--------|
| [README.md](README.md) | Repository overview and getting started | Everyone | Medium |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | Quick command reference | Users | Short |

### Using Benchmarks
| Document | Purpose | Audience | Length |
|----------|---------|----------|--------|
| [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) | Complete benchmarking guide | Users & Contributors | Long |
| [benches/README.md](benches/README.md) | Benchmark-specific documentation | Users | Medium |

### Understanding Changes
| Document | Purpose | Audience | Length |
|----------|---------|----------|--------|
| [CHANGES.md](CHANGES.md) | Recent additions (Dec 19, 2024) | Contributors | Medium |
| [MIGRATION.md](MIGRATION.md) | Historical context and migration | Maintainers | Long |
| [SUMMARY.md](SUMMARY.md) | Task completion summary | Project Managers | Medium |
| [CHECKLIST.md](CHECKLIST.md) | Verification checklist | QA/Reviewers | Medium |

## By Use Case

### "I want to run benchmarks"
1. Start: [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Get commands
2. Details: [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) - Learn options
3. Results: `target/criterion/report/index.html` - View results

### "I want to add a new benchmark"
1. Guide: [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md#contributing-new-benchmarks)
2. Examples: Look at existing files in `benches/benches/`
3. Reference: [benches/README.md](benches/README.md)

### "I want to compare performance"
1. Setup: [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md#performance-comparison-workflow)
2. Commands: [QUICK_REFERENCE.md](QUICK_REFERENCE.md#common-patterns)
3. Analysis: [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md#understanding-benchmark-results)

### "I want to understand what's here"
1. Overview: [README.md](README.md)
2. Benchmarks: [benches/README.md](benches/README.md)
3. History: [MIGRATION.md](MIGRATION.md)
4. Recent: [CHANGES.md](CHANGES.md)

## File Organization

### Root Level Documentation
```
📄 INDEX.md (this file) - Navigation guide
📄 README.md - Repository overview
📄 QUICK_REFERENCE.md - Command reference
📄 BENCHMARK_GUIDE.md - Complete guide
📄 MIGRATION.md - Historical documentation
📄 CHANGES.md - Recent changes
📄 SUMMARY.md - Task summary
📄 CHECKLIST.md - Verification checklist
```

### Benches Directory
```
📁 benches/
  📄 README.md - Benchmark documentation
  📄 Cargo.toml - Configuration
  📄 build.rs - Build script
  📁 benches/
    📄 *.rs - 12 benchmark files
    📄 *.txt - 3 data files
```

## Quick Reference by Topic

### Commands
- **Run all**: `cargo bench -p benches`
- **Timely only**: `cargo bench -p benches -- timely`
- **Specific bench**: `cargo bench -p benches --bench micro_ops`
- **View results**: `open target/criterion/report/index.html`

See [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for more

### Benchmarks Available
- arithmetic, fan_in, fan_out, fork_join
- futures, identity, join, micro_ops
- reachability, symmetric_hash_join, upcase, words_diamond

See [README.md](README.md#available-benchmarks) for details

### Implementations
- **Timely**: All 12 benchmarks
- **Differential**: reachability, symmetric_hash_join
- **Hydro**: All 12 benchmarks

See [benches/README.md](benches/README.md) for specifics

### New in December 2024
- futures.rs: Added timely implementation
- micro_ops.rs: Added 4 timely benchmarks
- symmetric_hash_join.rs: Added timely & differential
- words_diamond.rs: Added timely implementation

See [CHANGES.md](CHANGES.md) for details

## Search Tips

### Find Commands
```bash
grep -r "cargo bench" *.md
```

### Find Benchmark Details
```bash
grep -A5 "benchmark_name" benches/README.md
```

### Find Implementation Examples
```bash
grep -r "timely::example" benches/benches/*.rs
```

## Support and Resources

### Internal Resources
- Main Repository: https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta
- Benchmark code: `benches/benches/*.rs`
- Generated reports: `target/criterion/`

### External Resources
- Timely Dataflow: https://timelydataflow.github.io/timely-dataflow/
- Differential Dataflow: https://timelydataflow.github.io/differential-dataflow/
- Criterion: https://bheisler.github.io/criterion.rs/book/

## Contributing

When updating documentation:
1. Update the relevant specific document
2. Update this INDEX.md if adding new documentation
3. Update README.md if changing overall structure
4. Consider adding to CHANGES.md for significant updates

## Document Versions

- **INDEX.md** - Created December 19, 2024
- **README.md** - Updated December 19, 2024
- **BENCHMARK_GUIDE.md** - Created December 19, 2024
- **QUICK_REFERENCE.md** - Created December 19, 2024
- **CHANGES.md** - Created December 19, 2024
- **MIGRATION.md** - Updated December 19, 2024
- **SUMMARY.md** - Created December 19, 2024
- **CHECKLIST.md** - Created December 19, 2024
- **benches/README.md** - Updated December 19, 2024

---

**Need Help?** Start with [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for commands or [BENCHMARK_GUIDE.md](BENCHMARK_GUIDE.md) for detailed guidance.
