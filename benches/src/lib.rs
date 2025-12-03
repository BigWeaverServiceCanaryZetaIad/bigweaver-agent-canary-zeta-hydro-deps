/// Hydro Benchmarks Library
///
/// This library provides benchmark utilities and common test data for
/// performance comparison between Hydro and timely/differential-dataflow.

#![allow(dead_code)]

/// Generate test data for benchmarking
pub mod test_data {
    /// Generate a sequence of integers
    pub fn generate_sequence(size: usize) -> Vec<usize> {
        (0..size).collect()
    }
    
    /// Generate key-value pairs with controlled cardinality
    pub fn generate_key_value_pairs(size: usize, num_keys: usize) -> Vec<(usize, usize)> {
        (0..size).map(|i| (i % num_keys, i)).collect()
    }
    
    /// Generate graph edges (directed)
    pub fn generate_graph_edges(num_nodes: usize, edge_probability: f64) -> Vec<(u32, u32)> {
        use rand::Rng;
        let mut rng = rand::thread_rng();
        let mut edges = Vec::new();
        
        for i in 0..num_nodes {
            for j in 0..num_nodes {
                if i != j && rng.gen::<f64>() < edge_probability {
                    edges.push((i as u32, j as u32));
                }
            }
        }
        edges
    }
    
    /// Generate a chain graph (linear)
    pub fn generate_chain_graph(num_nodes: usize) -> Vec<(u32, u32)> {
        (0..num_nodes as u32 - 1).map(|i| (i, i + 1)).collect()
    }
    
    /// Generate a tree graph
    pub fn generate_tree_graph(depth: usize, branching_factor: usize) -> Vec<(u32, u32)> {
        let mut edges = Vec::new();
        let mut node_id = 0u32;
        
        fn generate_level(
            edges: &mut Vec<(u32, u32)>,
            parent: u32,
            node_id: &mut u32,
            depth: usize,
            branching_factor: usize,
        ) {
            if depth == 0 {
                return;
            }
            
            for _ in 0..branching_factor {
                *node_id += 1;
                let child = *node_id;
                edges.push((parent, child));
                generate_level(edges, child, node_id, depth - 1, branching_factor);
            }
        }
        
        generate_level(&mut edges, 0, &mut node_id, depth, branching_factor);
        edges
    }
}

/// Benchmark result utilities
pub mod results {
    use std::time::Duration;
    
    /// Format throughput for display
    pub fn format_throughput(elements: u64, duration: Duration) -> String {
        let ops_per_sec = elements as f64 / duration.as_secs_f64();
        if ops_per_sec > 1_000_000.0 {
            format!("{:.2}M ops/s", ops_per_sec / 1_000_000.0)
        } else if ops_per_sec > 1_000.0 {
            format!("{:.2}K ops/s", ops_per_sec / 1_000.0)
        } else {
            format!("{:.2} ops/s", ops_per_sec)
        }
    }
    
    /// Format latency for display
    pub fn format_latency(duration: Duration) -> String {
        if duration.as_millis() > 0 {
            format!("{:.2}ms", duration.as_secs_f64() * 1000.0)
        } else {
            format!("{:.2}μs", duration.as_micros())
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_generate_sequence() {
        let seq = test_data::generate_sequence(10);
        assert_eq!(seq.len(), 10);
        assert_eq!(seq[0], 0);
        assert_eq!(seq[9], 9);
    }
    
    #[test]
    fn test_generate_key_value_pairs() {
        let pairs = test_data::generate_key_value_pairs(100, 10);
        assert_eq!(pairs.len(), 100);
        // Check that keys are in range [0, 10)
        for (key, _) in pairs {
            assert!(key < 10);
        }
    }
    
    #[test]
    fn test_generate_chain_graph() {
        let edges = test_data::generate_chain_graph(5);
        assert_eq!(edges.len(), 4);
        assert_eq!(edges[0], (0, 1));
        assert_eq!(edges[3], (3, 4));
    }
    
    #[test]
    fn test_format_throughput() {
        use std::time::Duration;
        let result = results::format_throughput(1_000_000, Duration::from_secs(1));
        assert!(result.contains("M ops/s"));
    }
}
