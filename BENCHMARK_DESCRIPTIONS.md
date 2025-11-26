# Benchmark Descriptions

This document provides detailed descriptions of each benchmark that was migrated to the `bigweaver-agent-canary-zeta-hydro-deps` repository.

## Benchmark Files

### 1. arithmetic.rs
**Purpose**: Tests arithmetic operations through a dataflow pipeline  
**Operations**: Performs 20 sequential addition operations on 1,000,000 integers  
**Timely Implementation**: Uses `.map(|x| x + 1)` operators in a chain  
**Use Case**: Measures overhead of simple computational pipelines

### 2. fan_in.rs
**Purpose**: Tests stream concatenation (fan-in pattern)  
**Operations**: Concatenates 20 separate streams into one  
**Timely Implementation**: Uses `Concatenate` operator  
**Use Case**: Measures performance of merging multiple data sources

### 3. fan_out.rs
**Purpose**: Tests stream distribution (fan-out pattern)  
**Operations**: Distributes one stream to 20 consumers  
**Timely Implementation**: Uses multiple `.map()` operations on same stream  
**Use Case**: Measures performance of broadcasting data to multiple sinks

### 4. fork_join.rs
**Purpose**: Tests repeated splitting and joining of streams  
**Operations**: 20 iterations of splitting into 2 branches and rejoining  
**Timely Implementation**: Uses `Filter` and `Concatenate` operators  
**Use Case**: Measures performance of complex branching dataflow patterns

### 5. identity.rs
**Purpose**: Tests no-op operations through a pipeline  
**Operations**: Performs 20 identity operations (`.map(|x| x)`) on 1,000,000 integers  
**Timely Implementation**: Chain of identity maps  
**Use Case**: Measures baseline overhead of dataflow operators

### 6. join.rs
**Purpose**: Tests hash join operations  
**Operations**: Joins two streams of 10,000 elements each  
**Timely Implementation**: Custom `Operator` with `HashMap` state  
**Type Variants**: Tests with usize/usize, usize/String, String/usize, String/String  
**Use Case**: Measures join performance with different key/value types

### 7. upcase.rs
**Purpose**: Tests string transformation operations  
**Operations**: Performs 20 uppercasing operations on 100,000 strings  
**Timely Implementation**: Uses `.map()` with string operations  
**Variants**: 
  - `UpcaseInPlace`: Uses `make_ascii_uppercase()` (in-place modification)
  - `UpcaseClone`: Uses `to_ascii_uppercase()` (creates new string)  
**Use Case**: Measures performance of string processing in dataflows

### 8. reachability.rs ⭐ (Uses both Timely and Differential)
**Purpose**: Tests graph reachability algorithms  
**Operations**: Finds all nodes reachable from a starting node in a graph  
**Data**: Uses ~521KB edge data and validates against ~38KB expected results  

**Timely Implementation**: 
- Uses feedback loops with `Feedback` and `ConnectLoop`
- Manual state tracking with `HashSet`
- Iterative dataflow with `.flat_map()` for neighbor traversal

**Differential-Dataflow Implementation**:
- Uses `.iterate()` for fixed-point computation
- Uses `.semijoin()` for efficient graph traversal
- Uses `.distinct()` for deduplication
- Collection-based approach

**Use Case**: Benchmark for iterative graph algorithms, comparison of approaches

## Performance Characteristics

| Benchmark | Data Volume | Operations | Complexity |
|-----------|-------------|------------|------------|
| arithmetic | 1M ints | 20 ops | O(n) |
| fan_in | 20M ints total | 1 concat | O(n) |
| fan_out | 1M ints | 20 consumers | O(n) |
| fork_join | 100K ints | 20 splits/joins | O(n * 2^depth) |
| identity | 1M ints | 20 ops | O(n) |
| join | 10K pairs | 1 join | O(n log n) |
| upcase | 100K strings | 20 ops | O(n * m) |
| reachability | Graph data | Iterative | O(V + E) |

## Data Files

### reachability_edges.txt (521 KB)
Format: Space-separated pairs of node IDs representing directed edges
```
1 2
1 3
2 4
...
```

### reachability_reachable.txt (38 KB)
Format: One node ID per line representing expected reachable nodes from node 1
```
1
2
3
...
```

## Criterion Configuration

All benchmarks use Criterion with:
- `async_tokio` feature for async support
- `html_reports` feature for detailed HTML output
- `harness = false` for custom benchmark harness

## Running Individual Benchmarks

```bash
# Run with default settings
cargo bench --bench arithmetic

# Run with specific iterations
cargo bench --bench reachability -- --sample-size 10

# Generate HTML reports
cargo bench --bench join
# View results at: target/criterion/report/index.html
```
