# bigweaver-agent-canary-zeta-hydro-deps

This repository contains benchmarks and code that depend on timely-dataflow and differential-dataflow packages, which have been moved out of the main [bigweaver-agent-canary-hydro-zeta](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta) repository to reduce overhead and maintain a cleaner dependency structure.

## Contents

### Benchmarks

Performance benchmarks comparing Hydro with timely-dataflow and differential-dataflow implementations. These benchmarks were moved from the main repository to:
- Reduce build overhead for developers not working on performance comparisons
- Minimize security surface area by reducing dependencies
- Maintain clean separation of concerns

See [benches/README.md](benches/README.md) for instructions on running the benchmarks.

## Rationale

The timely-dataflow and differential-dataflow dependencies are primarily used for performance comparison benchmarks. By moving these benchmarks to a separate repository, we:

1. **Reduce dependency overhead**: Developers working on the main Hydro codebase don't need to pull in these additional dependencies
2. **Improve build performance**: Faster compile times for the main repository
3. **Reduce security surface area**: Fewer dependencies to monitor and maintain
4. **Maintain performance comparison capability**: Benchmarks remain accessible for performance testing when needed

## Running Benchmarks

To run the benchmarks:

```bash
# Clone this repository
git clone https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps.git
cd bigweaver-agent-canary-zeta-hydro-deps

# Run all benchmarks
cargo bench -p benches

# Run specific benchmarks
cargo bench -p benches --bench reachability
```

## Relationship to Main Repository

This repository references the main bigweaver-agent-canary-hydro-zeta repository via git dependencies for shared code like `dfir_rs` and `sinktools`. The benchmarks use a specific commit reference (rev = "484e6fdd") to ensure reproducibility and stability.

To update the reference to the main repository:
1. Update the `rev` parameter in `benches/Cargo.toml`
2. Test the benchmarks to ensure compatibility
3. Commit the changes