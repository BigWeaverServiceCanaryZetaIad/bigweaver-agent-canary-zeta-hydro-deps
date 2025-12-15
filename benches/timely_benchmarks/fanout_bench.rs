// Fanout benchmark using timely dataflow
// This benchmark tests the performance of fan-out operations in timely dataflow

use timely::dataflow::operators::{ToStream, Inspect};

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            (0..1_000_000u64)
                .to_stream(scope)
                .inspect(move |x| {
                    if index == 0 && x % 100_000 == 0 {
                        println!("Worker {}/{} saw: {}", index, peers, x);
                    }
                });
        });
        
        println!("Fanout benchmark completed on worker {}/{}", index, peers);
    }).expect("Timely computation failed");
}
