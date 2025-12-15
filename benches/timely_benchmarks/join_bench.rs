// Join benchmark using timely dataflow
// This benchmark tests the performance of join operations in timely dataflow

use timely::dataflow::operators::{ToStream, Join, Inspect};

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            let data1 = (0..10_000u32).map(|x| (x, x * 2)).to_stream(scope);
            let data2 = (0..10_000u32).map(|x| (x, x * 3)).to_stream(scope);
            
            data1.join(&data2)
                .inspect(move |x| {
                    if index == 0 && x.0 % 1_000 == 0 {
                        println!("Worker {}/{} joined: {:?}", index, peers, x);
                    }
                });
        });
        
        println!("Join benchmark completed on worker {}/{}", index, peers);
    }).expect("Timely computation failed");
}
