# 👋 Welcome to the Hydro Benchmarks Repository!

## What is this repository?

This repository contains **timely and differential-dataflow benchmarks** that were migrated from the main bigweaver-agent-canary-hydro-zeta repository. It provides performance comparison capabilities between Hydroflow/DFIR, Timely Dataflow, and Differential Dataflow.

## 🚀 Quick Start (3 steps)

1. **Install Rust** (if not already installed)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Run benchmarks**
   ```bash
   cargo bench -p benches
   ```

3. **View results**
   ```bash
   open target/criterion/report/index.html
   ```

## 📚 Documentation Guide

Start here based on what you need:

| I want to... | Read this document |
|--------------|-------------------|
| Get started quickly | [QUICK_START.md](QUICK_START.md) ⭐ |
| Understand the repository | [README.md](README.md) |
| Learn about performance testing | [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md) |
| See what changed | [CHANGES.md](CHANGES.md) |
| Understand the migration | [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) |
| Verify everything works | Run `bash verify_benchmarks.sh` |

## ✅ What's Included

- ✅ **12 Performance Benchmarks** - Comparing Hydroflow, Timely, and Differential Dataflow
- ✅ **Timely & Differential-Dataflow Dependencies** - All necessary dependencies included
- ✅ **Complete Documentation** - 5 comprehensive guides covering all aspects
- ✅ **Verification Tools** - Automated scripts to ensure everything works
- ✅ **Performance Comparison Tools** - Criterion.rs with statistical analysis and HTML reports

## 📊 Available Benchmarks

1. **arithmetic** - Arithmetic operations comparison
2. **fan_in** - Fan-in operations
3. **fan_out** - Fan-out operations
4. **fork_join** - Fork-join patterns
5. **futures** - Futures-based operations
6. **identity** - Identity operations
7. **join** - Join operations
8. **micro_ops** - Micro-operation benchmarks
9. **reachability** - Graph reachability algorithms (uses real graph data)
10. **symmetric_hash_join** - Symmetric hash join operations
11. **upcase** - String uppercase operations
12. **words_diamond** - Word processing in diamond topology (uses word list)

## 🎯 Common Commands

```bash
# Run all benchmarks
cargo bench -p benches

# Run specific benchmark
cargo bench -p benches --bench reachability

# Quick mode (fewer iterations, faster)
cargo bench -p benches -- --quick

# Check everything compiles
cargo check --workspace

# Verify repository setup
bash verify_benchmarks.sh
```

## 🏗️ Repository Structure

```
bigweaver-agent-canary-zeta-hydro-deps/
├── benches/              # Benchmark package with all 12 benchmarks
├── dfir_rs/             # DFIR runtime (required dependency)
├── lattices/            # Lattice types (required dependency)
├── [13 other deps]/     # Other required dependencies
├── Cargo.toml           # Workspace configuration
└── [documentation]/     # Comprehensive guides
```

## 💡 Key Features

### Performance Comparison
- Compare Hydroflow/DFIR vs Timely vs Differential Dataflow
- Statistical analysis with confidence intervals
- HTML reports with charts and graphs
- Historical comparison tracking

### Complete Functionality
- All dependencies included (standalone repository)
- Fully functional benchmarks
- No external setup required (beyond Rust toolchain)

### Comprehensive Documentation
- Quick start guide
- Detailed performance comparison guide
- Migration documentation
- Complete README

## 🔍 Verification

To verify everything is set up correctly:

```bash
bash verify_benchmarks.sh
```

This checks:
- ✅ All benchmark files present
- ✅ All data files present
- ✅ Dependencies configured correctly
- ✅ Workspace structure correct
- ✅ Documentation complete

## 📈 Performance Results

After running benchmarks, find results at:
- **HTML Reports**: `target/criterion/report/index.html`
- **Individual Benchmarks**: `target/criterion/<benchmark-name>/report/index.html`
- **Console Output**: Shows mean time, std dev, and comparison with previous runs

## 🤝 Contributing

When adding new benchmarks:
1. Create benchmark file in `benches/benches/`
2. Add configuration to `benches/Cargo.toml`
3. Document the benchmark purpose
4. Include multiple framework implementations
5. Test thoroughly

See [README.md](README.md) for detailed contribution guidelines.

## 📋 Task Completion Status

✅ All benchmark files copied (12 benchmarks)  
✅ Timely and differential-dataflow dependencies added  
✅ All required dependencies included (15 packages)  
✅ Benchmarks fully functional  
✅ Performance comparison capabilities preserved  
✅ Comprehensive documentation created  

See [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) for complete details.

## 🆘 Need Help?

1. **Quick Questions**: Check [QUICK_START.md](QUICK_START.md)
2. **Performance Testing**: Read [PERFORMANCE_COMPARISON_GUIDE.md](PERFORMANCE_COMPARISON_GUIDE.md)
3. **General Info**: See [README.md](README.md)
4. **Technical Issues**: Review verification script output
5. **Criterion Help**: Visit [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)

## 📦 Repository Info

- **Total Size**: ~17 MB
- **Total Files**: 1,367 files
- **Benchmark Files**: 12 Rust files
- **Data Files**: 3 files (4.3 MB)
- **Dependencies**: 15 workspace members
- **Documentation**: 5 comprehensive guides

## 🎓 Learn More

- Main Hydro Repository: bigweaver-agent-canary-hydro-zeta
- [Timely Dataflow](https://github.com/TimelyDataflow/timely-dataflow)
- [Differential Dataflow](https://github.com/TimelyDataflow/differential-dataflow)
- [Hydroflow Documentation](https://hydro.run/)
- [Criterion.rs](https://bheisler.github.io/criterion.rs/book/)

## 📝 License

Apache-2.0 - See [LICENSE](LICENSE) file

---

**Ready to start?** → [QUICK_START.md](QUICK_START.md)

**Want details?** → [README.md](README.md)

**Let's benchmark!** 🚀

```bash
cargo bench -p benches
```
