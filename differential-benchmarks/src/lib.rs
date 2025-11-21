//! Differential Dataflow Benchmarks
//!
//! This crate contains performance benchmarks for Differential Dataflow.
//!
//! ## Overview
//!
//! Differential dataflow is a data-parallel programming framework designed to
//! efficiently process large volumes of data and to quickly respond to changes
//! in input collections.
//!
//! ## Benchmarks
//!
//! - **Arrange**: Data arrangement performance
//! - **Join**: Join operation performance
//! - **Count**: Aggregation performance
//! - **Consolidate**: Data consolidation performance
//! - **Distinct**: Deduplication performance
//!
//! ## Usage
//!
//! Run benchmarks using:
//! ```bash
//! cargo bench --package differential-benchmarks
//! ```

#![warn(missing_docs)]

/// Utility functions for benchmark data generation
pub mod utils {
    use rand::{Rng, SeedableRng};
    use rand::rngs::StdRng;

    /// Generate a vector of random data for differential dataflow
    pub fn generate_random_data(size: usize, seed: u64) -> Vec<usize> {
        let mut rng = StdRng::seed_from_u64(seed);
        (0..size).map(|_| rng.gen::<usize>()).collect()
    }

    /// Generate key-value pairs for join benchmarks
    pub fn generate_join_data(
        size: usize,
        num_keys: usize,
        seed: u64,
    ) -> Vec<(usize, usize)> {
        let mut rng = StdRng::seed_from_u64(seed);
        (0..size)
            .map(|i| (i % num_keys, rng.gen::<usize>()))
            .collect()
    }

    /// Generate data with controlled duplicate factor
    pub fn generate_data_with_duplicates(
        unique_count: usize,
        duplicate_factor: usize,
    ) -> Vec<usize> {
        (0..unique_count)
            .flat_map(|i| std::iter::repeat(i).take(duplicate_factor))
            .collect()
    }

    /// Generate incremental updates (inserts and deletes)
    pub fn generate_updates(
        base_size: usize,
        update_size: usize,
        seed: u64,
    ) -> (Vec<usize>, Vec<usize>) {
        let mut rng = StdRng::seed_from_u64(seed);
        let inserts = (0..update_size).map(|_| rng.gen::<usize>()).collect();
        let deletes = (0..update_size)
            .map(|_| rng.gen_range(0..base_size))
            .collect();
        (inserts, deletes)
    }
}

/// Helper functions for benchmark setup
pub mod helpers {
    /// Calculate expected join output size
    pub fn expected_join_size(left_size: usize, right_size: usize, num_keys: usize) -> usize {
        // Average case: each key appears left_size/num_keys times in left
        // and right_size/num_keys times in right
        let left_per_key = left_size / num_keys;
        let right_per_key = right_size / num_keys;
        left_per_key * right_per_key * num_keys
    }

    /// Calculate expected distinct count
    pub fn expected_distinct_count(total_size: usize, num_keys: usize) -> usize {
        num_keys.min(total_size)
    }
}

#[cfg(test)]
mod tests {
    use super::utils::*;
    use super::helpers::*;

    #[test]
    fn test_generate_random_data() {
        let data = generate_random_data(100, 42);
        assert_eq!(data.len(), 100);
    }

    #[test]
    fn test_generate_join_data() {
        let data = generate_join_data(100, 10, 42);
        assert_eq!(data.len(), 100);
        assert!(data.iter().all(|(k, _)| *k < 10));
    }

    #[test]
    fn test_generate_data_with_duplicates() {
        let data = generate_data_with_duplicates(10, 5);
        assert_eq!(data.len(), 50);
        // Check each value appears exactly 5 times
        for i in 0..10 {
            assert_eq!(data.iter().filter(|&&x| x == i).count(), 5);
        }
    }

    #[test]
    fn test_generate_updates() {
        let (inserts, deletes) = generate_updates(100, 20, 42);
        assert_eq!(inserts.len(), 20);
        assert_eq!(deletes.len(), 20);
        assert!(deletes.iter().all(|&x| x < 100));
    }

    #[test]
    fn test_expected_join_size() {
        assert_eq!(expected_join_size(1000, 1000, 10), 10000);
        assert_eq!(expected_join_size(100, 100, 10), 100);
    }

    #[test]
    fn test_expected_distinct_count() {
        assert_eq!(expected_distinct_count(100, 10), 10);
        assert_eq!(expected_distinct_count(100, 200), 100);
    }
}
