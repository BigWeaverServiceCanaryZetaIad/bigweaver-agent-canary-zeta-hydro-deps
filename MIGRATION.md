# Benchmark Migration Documentation

This document describes the benchmarks that have been migrated from the main Hydro repository to this deps repository.

## Migration Date

December 12, 2025

## Purpose of Migration

These benchmarks were moved to this repository to:

1. **Remove Dependencies**: Keep timely-dataflow and differential-dataflow out of the main Hydro repository's dependency tree
2. **Enable Comparisons**: Maintain the ability to benchmark Hydro against established streaming frameworks
3. **Improve Build Times**: Reduce compile times for the main repository by removing heavy dependencies
4. **Architectural Clarity**: Separate external framework comparisons from native Hydro development

## Migrated Benchmarks

The following benchmarks using timely-dataflow and differential-dataflow were extracted from commit `84b3cdf1^` of the main repository:

### Timely-Dataflow Benchmarks

1. **arithmetic.rs** - Chain of arithmetic operations on a stream
   - Tests map operations and dataflow overhead
   - Constant: 20 operations, 1M integers

2. **fan_in.rs** - Multiple input streams merging into one
   - Tests stream concatenation
   - Constant: 20 input streams, 1M integers per stream

3. **fan_out.rs** - Single stream splitting into multiple outputs
   - Tests stream cloning and broadcasting
   - Constant: 20 output streams, 1M integers

4. **fork_join.rs** - Fork-join pattern with filtering
   - Tests filtering and re-merging of streams
   - Constants: 20 operations, 100K integers, branch factor of 2

5. **identity.rs** - Identity transformation (pass-through)
   - Tests minimal overhead of dataflow operations
   - Constants: 20 operations, 1M integers

6. **join.rs** - Hash join of two streams
   - Tests symmetric hash join implementation
   - Constant: 100K integers per stream
   - Variants: usize×usize and String×String

7. **upcase.rs** - String transformation operations
   - Tests string manipulation in dataflow
   - Constants: 20 operations, 100K rows
   - Variants: in-place, allocating, concatenating

### Differential-Dataflow Benchmarks

8. **reachability.rs** - Graph reachability computation
   - Tests iterative graph algorithms using differential dataflow
   - Includes both timely and differential implementations
   - Uses real graph data from included text files

### Supporting Files

- **reachability_edges.txt** - Graph edges for reachability benchmark (~520 KB)
- **reachability_reachable.txt** - Expected reachable nodes (~38 KB)
- **.gitignore** - Criterion output directory exclusions
- **build.rs** - Build script for the benchmark package

## Changes Made During Migration

1. **Removed Hydro Dependencies**: All references to `dfir_rs` and `sinktools` were removed
2. **Simplified Benchmark Functions**: Only kept timely/differential benchmark functions, removed Hydro equivalents
3. **Updated Criterion Groups**: Modified to only include the timely/differential functions
4. **Standalone Package**: Created a standalone Cargo.toml without workspace dependencies
5. **Documentation**: Added comprehensive README and this migration document

## Source Repository State

After migration, the main repository (`bigweaver-agent-canary-hydro-zeta`):

- ✅ No longer has timely or differential-dataflow dependencies
- ✅ Retains Hydro-native benchmark implementations (if any)
- ✅ Includes cross-repository comparison guide (`BENCHMARK_COMPARISON.md`)
- ✅ Can build without external dataflow framework dependencies

## Usage

See the [README.md](README.md) for instructions on:
- Building and running benchmarks
- Comparing results with Hydro
- Interpreting benchmark outputs

## Cross-Repository Comparison

For detailed instructions on comparing these benchmarks with Hydro implementations, see:
- [BENCHMARK_COMPARISON.md](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_COMPARISON.md) in the main repository
- [README.md](benches/README.md) in the benches directory

## Future Additions

When adding new comparison benchmarks:

1. Implement the Hydro version in the main repository first
2. If comparing against timely/differential, add the reference implementation here
3. Update both repositories' documentation
4. Ensure benchmark names and patterns are consistent

## Verification

To verify the migration was successful:

```bash
# Check main repo has no timely/differential dependencies
cd ../bigweaver-agent-canary-hydro-zeta
grep -r "timely\|differential" --include="*.toml" .
# Should return no results

# Check deps repo builds successfully
cd ../bigweaver-agent-canary-zeta-hydro-deps/benches
cargo check
cargo bench --no-run

# Verify all benchmarks are present
ls benches/*.rs
# Should show all 8 benchmark files
```

## Related Documentation

- [Main Repository README](../bigweaver-agent-canary-hydro-zeta/README.md)
- [Benchmark Comparison Guide](../bigweaver-agent-canary-hydro-zeta/BENCHMARK_COMPARISON.md)
- [Benches README](benches/README.md)
