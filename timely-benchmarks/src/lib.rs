//! Timely Dataflow Benchmarks
//!
//! This crate contains performance benchmarks for the Timely Dataflow system.
//!
//! ## Overview
//!
//! Timely dataflow is a low-latency cyclic dataflow computational model,
//! introduced in the paper [Naiad: a timely dataflow system](https://dl.acm.org/doi/10.1145/2517349.2522738).
//!
//! ## Benchmarks
//!
//! - **Barrier**: Synchronization overhead
//! - **Exchange**: Data exchange and partitioning
//! - **Dataflow Construction**: Graph construction overhead
//! - **Progress Tracking**: Progress tracking mechanisms
//! - **Unary Operators**: Basic operator performance
//!
//! ## Usage
//!
//! Run benchmarks using:
//! ```bash
//! cargo bench --package timely-benchmarks
//! ```

#![warn(missing_docs)]

/// Utility functions for benchmark data generation
pub mod utils {
    use rand::{Rng, SeedableRng};
    use rand::rngs::StdRng;

    /// Generate a vector of random integers
    pub fn generate_random_data(size: usize, seed: u64) -> Vec<usize> {
        let mut rng = StdRng::seed_from_u64(seed);
        (0..size).map(|_| rng.gen::<usize>()).collect()
    }

    /// Generate a vector of sequential integers
    pub fn generate_sequential_data(size: usize) -> Vec<usize> {
        (0..size).collect()
    }

    /// Generate key-value pairs with controllable key cardinality
    pub fn generate_keyed_data(size: usize, num_keys: usize, seed: u64) -> Vec<(usize, usize)> {
        let mut rng = StdRng::seed_from_u64(seed);
        (0..size)
            .map(|i| (i % num_keys, rng.gen::<usize>()))
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::utils::*;

    #[test]
    fn test_generate_random_data() {
        let data = generate_random_data(100, 42);
        assert_eq!(data.len(), 100);
        // Same seed should produce same data
        let data2 = generate_random_data(100, 42);
        assert_eq!(data, data2);
    }

    #[test]
    fn test_generate_sequential_data() {
        let data = generate_sequential_data(10);
        assert_eq!(data, vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    }

    #[test]
    fn test_generate_keyed_data() {
        let data = generate_keyed_data(100, 10, 42);
        assert_eq!(data.len(), 100);
        // Check all keys are within range
        assert!(data.iter().all(|(k, _)| *k < 10));
    }
}
