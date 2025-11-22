# Documentation Index

Welcome to the Hydro Benchmarks repository! This index will help you find the right documentation for your needs.

## 🚀 Quick Navigation

### I want to...

#### **Get started quickly**
→ Read [GETTING_STARTED.md](GETTING_STARTED.md) (5 minute read)

#### **Run a benchmark right now**
→ See [benches/QUICK_START.md](benches/QUICK_START.md) (Quick reference)

#### **Understand what the benchmarks do**
→ Read [benches/EXAMPLES.md](benches/EXAMPLES.md) (Detailed explanations)

#### **Learn about the migration**
→ See [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) (In main repo)

#### **See what changed**
→ Check [CHANGELOG.md](CHANGELOG.md) (Complete history)

#### **Troubleshoot setup issues**
→ Run [benches/setup.sh](benches/setup.sh) (Automated diagnostics)

## 📚 Documentation Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── INDEX.md                    ← You are here
├── GETTING_STARTED.md          ← Start here for new users
├── README.md                   ← Repository overview
├── CHANGELOG.md                ← What changed and when
├── MIGRATION_SUMMARY.txt       ← Technical migration details
└── benches/
    ├── QUICK_START.md          ← Quick reference commands
    ├── EXAMPLES.md             ← Detailed benchmark examples
    ├── setup.sh                ← Setup verification script
    ├── README.md               ← Benchmark-specific docs
    ├── Cargo.toml              ← Project configuration
    └── benches/                ← Benchmark implementations
```

## 📖 Documentation Guide

### For New Users

**Start Here:**
1. [GETTING_STARTED.md](GETTING_STARTED.md) - 5 minute introduction
2. [benches/setup.sh](benches/setup.sh) - Verify your setup
3. [benches/QUICK_START.md](benches/QUICK_START.md) - Try your first benchmark

**Then Explore:**
- [benches/EXAMPLES.md](benches/EXAMPLES.md) - Learn how benchmarks work
- [README.md](README.md) - Full repository documentation

### For Experienced Users

**Quick Reference:**
- [benches/QUICK_START.md](benches/QUICK_START.md) - Commands and options
- [benches/Cargo.toml](benches/Cargo.toml) - Available benchmarks
- [benches/benches/](benches/benches/) - Source code

**Advanced:**
- [benches/EXAMPLES.md](benches/EXAMPLES.md) - Implementation details
- [benches/build.rs](benches/build.rs) - Build script

### For Developers

**Migration & Architecture:**
- [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md) - Migration guide
- [CHANGELOG.md](CHANGELOG.md) - Complete change history
- [MIGRATION_SUMMARY.txt](MIGRATION_SUMMARY.txt) - Technical details

**Contributing:**
- [README.md](README.md#contributing) - How to add benchmarks
- [benches/EXAMPLES.md](benches/EXAMPLES.md#adding-new-benchmarks) - Benchmark template

## 📋 Quick Reference

### Files by Purpose

| Purpose | File | Description |
|---------|------|-------------|
| **Getting Started** | GETTING_STARTED.md | New user guide (start here!) |
| **Quick Commands** | benches/QUICK_START.md | Command reference |
| **Learn Benchmarks** | benches/EXAMPLES.md | Detailed examples |
| **Setup Check** | benches/setup.sh | Verify configuration |
| **Overview** | README.md | Full documentation |
| **Changes** | CHANGELOG.md | What's new |
| **Migration** | BENCHMARK_MIGRATION.md | Migration details |
| **Technical** | MIGRATION_SUMMARY.txt | Technical summary |

### Benchmarks by Type

| Type | Benchmarks | File |
|------|------------|------|
| **Basic** | identity, arithmetic, fan_in, fan_out, upcase | See QUICK_START.md |
| **Joins** | join, symmetric_hash_join, reachability | See QUICK_START.md |
| **Complex** | fork_join, futures, words_diamond, micro_ops | See QUICK_START.md |

### Documentation by Experience Level

| Level | Recommended Reading | Time |
|-------|-------------------|------|
| **Beginner** | GETTING_STARTED.md → setup.sh → QUICK_START.md | 10 min |
| **Intermediate** | README.md → EXAMPLES.md → Source code | 30 min |
| **Advanced** | BENCHMARK_MIGRATION.md → Cargo.toml → Implementation | 60 min |

## 🔍 Find Specific Information

### Setup & Installation
- Prerequisites: [GETTING_STARTED.md#prerequisites](GETTING_STARTED.md)
- Verify setup: [benches/setup.sh](benches/setup.sh)
- Directory structure: [GETTING_STARTED.md#troubleshooting](GETTING_STARTED.md)

### Running Benchmarks
- All commands: [benches/QUICK_START.md](benches/QUICK_START.md)
- Quick test: `cargo bench --bench identity`
- View results: `target/criterion/report/index.html`

### Understanding Benchmarks
- What each does: [benches/EXAMPLES.md](benches/EXAMPLES.md)
- How they work: [benches/EXAMPLES.md#benchmark-structure](benches/EXAMPLES.md)
- Performance analysis: [benches/EXAMPLES.md#performance-analysis](benches/EXAMPLES.md)

### Migration Information
- Why migrate: [BENCHMARK_MIGRATION.md#rationale](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md)
- What moved: [CHANGELOG.md](CHANGELOG.md)
- Technical details: [MIGRATION_SUMMARY.txt](MIGRATION_SUMMARY.txt)

### Troubleshooting
- Setup issues: Run [benches/setup.sh](benches/setup.sh)
- Common errors: [GETTING_STARTED.md#troubleshooting](GETTING_STARTED.md)
- Build problems: [benches/QUICK_START.md#troubleshooting](benches/QUICK_START.md)

### Adding/Modifying Benchmarks
- Template: [benches/EXAMPLES.md#adding-new-benchmarks](benches/EXAMPLES.md)
- Register: [benches/Cargo.toml](benches/Cargo.toml)
- Best practices: [benches/EXAMPLES.md#best-practices](benches/EXAMPLES.md)

## 📊 Documentation Stats

- **Total Documentation**: 8 files, ~2,500 lines
- **Code Examples**: 50+ code snippets
- **Command Examples**: 30+ command examples
- **Benchmarks Documented**: 12 benchmarks
- **Coverage**: Complete (all features documented)

## 🎯 Common Workflows

### First Time Setup
```bash
1. Read GETTING_STARTED.md
2. Run: cd benches && ./setup.sh
3. Try: cargo bench --bench identity
4. View: open target/criterion/report/index.html
```

### Regular Usage
```bash
1. See: benches/QUICK_START.md for commands
2. Run: cargo bench --bench <name>
3. Review results in criterion reports
```

### Performance Testing
```bash
1. Save baseline: cargo bench -- --save-baseline before
2. Make changes to Hydro
3. Compare: cargo bench -- --baseline before
4. See: benches/EXAMPLES.md for analysis tips
```

### Adding New Benchmark
```bash
1. Read: benches/EXAMPLES.md#adding-new-benchmarks
2. Create: benches/benches/my_benchmark.rs
3. Register: Add [[bench]] to Cargo.toml
4. Test: cargo bench --bench my_benchmark
5. Document: Update README.md and EXAMPLES.md
```

## 🔗 Related Resources

### External Documentation
- Criterion Framework: https://bheisler.github.io/criterion.rs/book/
- Timely Dataflow: https://github.com/TimelyDataflow/timely-dataflow
- Differential Dataflow: https://github.com/TimelyDataflow/differential-dataflow

### Main Hydro Repository
- Location: `../bigweaver-agent-canary-hydro-zeta/`
- Migration docs: [BENCHMARK_MIGRATION.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_MIGRATION.md)

## 💡 Tips

- **Start simple**: Try `identity` benchmark first
- **Use setup script**: It catches most issues
- **Read examples**: Understand before modifying
- **Save baselines**: Track performance over time
- **Check reports**: HTML reports have detailed stats

## ❓ Still Have Questions?

1. **Setup issues**: Run `./setup.sh` for diagnostics
2. **Usage questions**: Check QUICK_START.md
3. **Understanding benchmarks**: Read EXAMPLES.md
4. **Migration details**: See BENCHMARK_MIGRATION.md

---

**Happy Benchmarking! 🚀**

For the fastest start, go directly to [GETTING_STARTED.md](GETTING_STARTED.md)
