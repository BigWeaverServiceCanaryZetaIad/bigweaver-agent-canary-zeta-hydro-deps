/// Simple standalone example demonstrating timely and differential dataflow
/// 
/// Run with: cargo run --example simple_benchmark --release
use std::time::Instant;

fn timely_example() {
    println!("\n=== Timely Dataflow Example ===");
    let start = Instant::now();
    
    timely::execute_directly(|worker| {
        use timely::dataflow::operators::{Map, Probe, ToStream};
        use timely::dataflow::InputHandle;
        
        let mut input = InputHandle::new();
        let mut probe = timely::dataflow::ProbeHandle::new();
        
        worker.dataflow(|scope| {
            input
                .to_stream(scope)
                .map(|x: u64| x * 2)
                .probe_with(&mut probe);
        });
        
        for i in 0..10_000 {
            input.send(i);
        }
        input.advance_to(1);
        while probe.less_than(input.time()) {
            worker.step();
        }
    });
    
    let duration = start.elapsed();
    println!("Processed 10,000 items in {:?}", duration);
    println!("Throughput: {:.2} items/sec", 10_000.0 / duration.as_secs_f64());
}

fn differential_example() {
    println!("\n=== Differential Dataflow Example ===");
    let start = Instant::now();
    
    timely::execute_directly(|worker| {
        use differential_dataflow::input::InputSession;
        use differential_dataflow::operators::Count;
        use timely::dataflow::operators::Probe;
        
        let mut input = InputSession::new();
        let mut probe = timely::dataflow::ProbeHandle::new();
        
        worker.dataflow(|scope| {
            input
                .to_collection(scope)
                .map(|x: u64| x % 100)
                .count()
                .probe_with(&mut probe);
        });
        
        for i in 0..10_000 {
            input.insert(i);
        }
        input.advance_to(1);
        input.flush();
        while probe.less_than(&1) {
            worker.step();
        }
    });
    
    let duration = start.elapsed();
    println!("Processed 10,000 items (with counting) in {:?}", duration);
    println!("Throughput: {:.2} items/sec", 10_000.0 / duration.as_secs_f64());
}

fn differential_incremental_example() {
    println!("\n=== Differential Dataflow Incremental Update ===");
    
    timely::execute_directly(|worker| {
        use differential_dataflow::input::InputSession;
        use differential_dataflow::operators::Count;
        use timely::dataflow::operators::Probe;
        
        let mut input = InputSession::new();
        let mut probe = timely::dataflow::ProbeHandle::new();
        
        worker.dataflow(|scope| {
            input
                .to_collection(scope)
                .map(|x: u64| x % 100)
                .count()
                .probe_with(&mut probe);
        });
        
        // Initial batch
        println!("Loading initial 10,000 items...");
        let start = Instant::now();
        for i in 0..10_000 {
            input.insert(i);
        }
        input.advance_to(1);
        input.flush();
        while probe.less_than(&1) {
            worker.step();
        }
        println!("Initial load: {:?}", start.elapsed());
        
        // Incremental update - this is where differential shines
        println!("Adding 100 new items...");
        let start = Instant::now();
        for i in 10_000..10_100 {
            input.insert(i);
        }
        input.advance_to(2);
        input.flush();
        while probe.less_than(&2) {
            worker.step();
        }
        let incremental_duration = start.elapsed();
        println!("Incremental update: {:?}", incremental_duration);
        println!("Note: Differential recomputes only what changed!");
    });
}

fn main() {
    println!("Timely and Differential Dataflow Simple Benchmarks");
    println!("===================================================");
    
    timely_example();
    differential_example();
    differential_incremental_example();
    
    println!("\n=== Summary ===");
    println!("- Timely: Great for streaming data processing");
    println!("- Differential: Excellent for incremental computation");
    println!("- Use Differential when you have changing data and want to recompute efficiently");
    println!("\nRun full benchmarks with: cargo bench -p timely-differential-benches");
}
