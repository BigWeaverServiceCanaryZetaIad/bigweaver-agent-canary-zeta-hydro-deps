// Reachability benchmark using timely dataflow
// This benchmark tests graph reachability operations in timely dataflow

use timely::dataflow::operators::{ToStream, Concat, LoopVariable, ConnectLoop, Inspect};

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            // Create a simple graph as edges
            let edges = vec![(0u32, 1u32), (1, 2), (2, 3), (3, 4), (4, 5)]
                .into_iter()
                .to_stream(scope);
            
            let (handle, stream) = scope.loop_variable(100);
            
            edges.concat(&stream)
                .inspect(move |x| {
                    if index == 0 {
                        println!("Worker {}/{} found edge: {:?}", index, peers, x);
                    }
                })
                .connect_loop(handle);
        });
        
        println!("Reachability benchmark completed on worker {}/{}", index, peers);
    }).expect("Timely computation failed");
}
