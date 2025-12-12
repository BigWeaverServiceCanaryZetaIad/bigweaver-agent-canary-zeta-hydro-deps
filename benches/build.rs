fn main() {
    // Optimization settings for benchmarks
    println!("cargo:rerun-if-changed=build.rs");
    
    // Enable optimizations even in dev mode for more accurate benchmarking
    #[cfg(debug_assertions)]
    {
        println!("cargo:warning=Building benchmarks in debug mode. For accurate results, use --release");
    }
}
