/// Common utilities for benchmarks
use std::time::{Duration, Instant};

/// Graph edge representation
pub type Edge = (u32, u32);

/// Generate a random graph with specified nodes and edges
pub fn generate_random_graph(nodes: u32, edges: usize, seed: u64) -> Vec<Edge> {
    use rand::{Rng, SeedableRng};
    use rand::rngs::StdRng;
    
    let mut rng = StdRng::seed_from_u64(seed);
    (0..edges)
        .map(|_| {
            let src = rng.gen_range(0..nodes);
            let dst = rng.gen_range(0..nodes);
            (src, dst)
        })
        .collect()
}

/// Generate a chain graph (linear sequence)
pub fn generate_chain_graph(length: u32) -> Vec<Edge> {
    (0..length - 1).map(|i| (i, i + 1)).collect()
}

/// Generate a complete graph
pub fn generate_complete_graph(nodes: u32) -> Vec<Edge> {
    let mut edges = Vec::new();
    for i in 0..nodes {
        for j in 0..nodes {
            if i != j {
                edges.push((i, j));
            }
        }
    }
    edges
}

/// Performance measurement result
#[derive(Debug, Clone)]
pub struct PerfResult {
    pub name: String,
    pub duration: Duration,
    pub items_processed: usize,
    pub throughput: f64, // items per second
}

impl PerfResult {
    pub fn new(name: String, duration: Duration, items_processed: usize) -> Self {
        let throughput = items_processed as f64 / duration.as_secs_f64();
        Self {
            name,
            duration,
            items_processed,
            throughput,
        }
    }

    pub fn print_summary(&self) {
        println!(
            "{}: {:?} ({:.2} items/sec, {} items)",
            self.name, self.duration, self.throughput, self.items_processed
        );
    }
}

/// Timer utility for simple performance measurements
pub struct Timer {
    start: Instant,
}

impl Timer {
    pub fn new() -> Self {
        Self {
            start: Instant::now(),
        }
    }

    pub fn elapsed(&self) -> Duration {
        self.start.elapsed()
    }

    pub fn finish(self, name: String, items: usize) -> PerfResult {
        PerfResult::new(name, self.elapsed(), items)
    }
}

impl Default for Timer {
    fn default() -> Self {
        Self::new()
    }
}

/// Comparison result between two benchmarks
#[derive(Debug)]
pub struct ComparisonResult {
    pub baseline: PerfResult,
    pub comparison: PerfResult,
    pub speedup: f64,
}

impl ComparisonResult {
    pub fn new(baseline: PerfResult, comparison: PerfResult) -> Self {
        let speedup = baseline.duration.as_secs_f64() / comparison.duration.as_secs_f64();
        Self {
            baseline,
            comparison,
            speedup,
        }
    }

    pub fn print_summary(&self) {
        println!("\n=== Comparison ===");
        self.baseline.print_summary();
        self.comparison.print_summary();
        println!(
            "Speedup: {:.2}x ({} is {:.2}% {})",
            self.speedup.abs(),
            self.comparison.name,
            (self.speedup.abs() - 1.0) * 100.0,
            if self.speedup > 1.0 { "faster" } else { "slower" }
        );
    }
}
