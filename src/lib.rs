//! Hydroflow External Framework Benchmarks
//!
//! This library provides performance comparison benchmarks between Hydroflow and
//! external dataflow frameworks (Timely Dataflow and Differential Dataflow).
//!
//! The benchmarks are kept in a separate repository to avoid polluting the main
//! Hydroflow repository with external dependencies.

/// Common benchmark utilities and shared code
pub mod utils {
    use std::hint::black_box;

    /// Standard number of operations for identity-like benchmarks
    pub const NUM_OPS: usize = 20;
    
    /// Standard number of integers to process
    pub const NUM_INTS: usize = 1_000_000;
    
    /// Standard number of join elements
    pub const NUM_JOIN_ELEMENTS: usize = 100_000;

    /// Helper to consume values without optimization
    #[inline]
    pub fn consume<T>(value: T) -> T {
        black_box(value)
    }

    /// Generate test data for benchmarks
    pub fn generate_ints(count: usize) -> Vec<usize> {
        (0..count).collect()
    }

    /// Generate pairs for join benchmarks
    pub fn generate_join_pairs(count: usize) -> (Vec<(usize, String)>, Vec<(usize, usize)>) {
        let lhs: Vec<_> = (0..count)
            .map(|i| (i % (count / 10), format!("left_{}", i)))
            .collect();
        let rhs: Vec<_> = (0..count)
            .map(|i| (i % (count / 10), i * 2))
            .collect();
        (lhs, rhs)
    }
}

/// Benchmark metrics and comparison utilities
pub mod metrics {
    use std::time::Duration;

    #[derive(Debug, Clone)]
    pub struct BenchmarkResult {
        pub framework: String,
        pub benchmark_name: String,
        pub mean_time: Duration,
        pub throughput_eps: f64,
        pub elements_processed: usize,
    }

    impl BenchmarkResult {
        pub fn new(
            framework: impl Into<String>,
            benchmark_name: impl Into<String>,
            mean_time: Duration,
            elements_processed: usize,
        ) -> Self {
            let time_s = mean_time.as_secs_f64();
            let throughput_eps = elements_processed as f64 / time_s;
            Self {
                framework: framework.into(),
                benchmark_name: benchmark_name.into(),
                mean_time,
                throughput_eps,
                elements_processed,
            }
        }

        pub fn print_comparison(&self, baseline: &BenchmarkResult) {
            let speedup = baseline.mean_time.as_secs_f64() / self.mean_time.as_secs_f64();
            println!(
                "{}: {:.2?} ({:.2}x vs {})",
                self.framework, self.mean_time, speedup, baseline.framework
            );
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_generate_ints() {
        let ints = utils::generate_ints(100);
        assert_eq!(ints.len(), 100);
        assert_eq!(ints[0], 0);
        assert_eq!(ints[99], 99);
    }

    #[test]
    fn test_generate_join_pairs() {
        let (lhs, rhs) = utils::generate_join_pairs(100);
        assert_eq!(lhs.len(), 100);
        assert_eq!(rhs.len(), 100);
    }
}
