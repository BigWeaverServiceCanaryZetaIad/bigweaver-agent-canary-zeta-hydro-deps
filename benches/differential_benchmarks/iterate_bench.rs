// Iterate benchmark using differential dataflow
// This benchmark tests the performance of iterative computations

use timely::dataflow::operators::ToStream;
use differential_dataflow::operators::Iterate;
use differential_dataflow::operators::Join;

fn main() {
    timely::execute_from_args(std::env::args(), |worker| {
        let index = worker.index();
        let peers = worker.peers();
        
        worker.dataflow::<u64, _, _>(|scope| {
            let edges = vec![(0u32, 1u32), (1, 2), (2, 3), (3, 0)]
                .into_iter()
                .to_stream(scope)
                .map(|x| (x, ()))
                .as_collection();
            
            edges.iterate(|paths| {
                edges.join_map(&paths, |_src, &dst, &()| (dst, ()))
                    .concat(&edges)
                    .distinct()
            })
            .inspect(move |x| {
                if index == 0 {
                    println!("Worker {}/{} found path: {:?}", index, peers, x);
                }
            });
        });
        
        println!("Iterate benchmark completed on worker {}/{}", index, peers);
    }).expect("Differential computation failed");
}
