---
---
# Hydro/DFIR Performance Benchmarks

This site hosts performance benchmark results comparing DFIR with timely and differential-dataflow frameworks.

## Links

- [Main Hydro Repository 🔗](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-hydro-zeta)
- [Benchmarks Repository 🔗](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps)
- [Benchmark History]({{ "/bench/" | prepend: site.github.url | replace: 'https://', '//' }})
- [Latest Benchmarks]({{ "/criterion/report/" | prepend: site.github.url | replace: 'https://', '//' }})

## About

These benchmarks track the performance of DFIR operations over time and compare them with alternative dataflow frameworks. Benchmarks are run automatically:

- Daily at 3:35 AM UTC
- On commits to main with `[ci-bench]` tag
- On pull requests with `[ci-bench]` tag
- Manually via GitHub Actions

## Benchmark Suite

The suite includes 12 microbenchmarks covering:
- Arithmetic operations
- Join patterns
- Fan-in/Fan-out patterns
- String processing
- Graph algorithms
- Futures handling

See the [repository](https://github.com/BigWeaverServiceCanaryZetaIad/bigweaver-agent-canary-zeta-hydro-deps) for more details.
