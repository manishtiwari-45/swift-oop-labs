# Lab 01 - Breadth First Search (BFS) using Graphs in Swift

## Overview

This lab is my Swift implementation of the BFS (Breadth First Search) graph traversal algorithm.

The original assignment was designed for Java in an Advanced Object-Oriented Programming course. Instead of implementing it in Java, I rebuilt the solution in Swift to strengthen my understanding of Swift syntax, object-oriented design, collections, and algorithm implementation.

The goal of the lab is to represent a graph using an adjacency list and perform Breadth First Search starting from a chosen vertex.

---

# Problem Statement

Given a graph containing multiple vertices and edges, traverse all reachable vertices using Breadth First Search (BFS).

BFS explores a graph level by level:

1. Visit the starting vertex
2. Visit all direct neighbors
3. Visit neighbors of those neighbors
4. Continue until all reachable vertices are visited

---

# Swift Concepts Practiced

## Classes

The graph is represented using a Swift class.

```swift
class Graph
```

Classes are reference types in Swift.

This means multiple variables can refer to the same graph object.

This behavior is similar to Java objects.

---

## Encapsulation

The graph implementation hides internal details.

```swift
private var adjacencyList: [[Int]]
```

External code cannot directly modify the graph structure.

Instead, interactions happen through public methods:

```swift
addEdge()
bfs()
```

This prevents accidental corruption of graph data.

### Real Engineering Example

Most production systems hide internal implementation details.

For example:

* Database clients hide SQL connection management
* Networking libraries hide socket implementation
* UIKit hides rendering internals

Encapsulation reduces bugs and makes APIs safer.

---

## Arrays

Swift arrays are heavily used throughout this lab.

```swift
var queue: [Int]
```

```swift
var visited: [Bool]
```

Swift arrays are dynamic and type-safe.

Compared to Java:

```java
ArrayList<Integer>
```

Swift arrays require less boilerplate while maintaining safety.

---

## Error Handling

Instead of Java exceptions:

```java
throw new IllegalArgumentException(...)
```

Swift uses:

```swift
throw GraphError.invalidVertex(...)
```

Functions that may fail are marked with:

```swift
func bfs(...) throws
```

The caller must explicitly handle errors.

### Why This Matters

Swift forces developers to acknowledge failure cases.

This reduces many runtime bugs caused by ignored exceptions.

---

## Guard Statements

Swift commonly uses guard for validation.

```swift
guard isValidVertex(vertex) else {
    throw GraphError.invalidVertex(vertex)
}
```

Benefits:

* Early exit
* Better readability
* Fewer nested if statements

Guard is widely used throughout professional Swift codebases.

---

# Graph Representation

The graph uses an adjacency list.

```swift
[
    [1,2],
    [0,3],
    [0,3],
    [1,2]
]
```

Each index represents a vertex.

Each array stores neighboring vertices.

---

## Why Adjacency Lists?

Advantages:

* Memory efficient
* Fast neighbor lookup
* Ideal for sparse graphs

Most real-world graphs are sparse.

Examples:

* Social networks
* Transportation systems
* Computer networks

Because of this, adjacency lists are preferred over adjacency matrices in production systems.

---

# Breadth First Search (BFS)

BFS uses a Queue.

```swift
var queue: [Int]
```

Algorithm:

1. Enqueue start vertex
2. Mark visited
3. Remove first element
4. Visit neighbors
5. Repeat

---

# Why BFS Uses a Queue

Queues follow FIFO.

First In First Out.

This guarantees level-by-level traversal.

Example:

```text
0
| \
1  2
|
3
```

Traversal:

```text
0 1 2 3
```

Vertices closer to the source are always processed first.

---

# Real Engineering Applications

## GPS Navigation

Road networks can be modeled as graphs.

BFS can find shortest paths when all roads have equal cost.

---

## Social Networks

Platforms such as:

* LinkedIn
* Facebook

Use graph traversal to explore connections.

Example:

"Show mutual friends"

---

## Web Crawlers

Search engines discover pages through links.

Links form a graph.

Traversal algorithms are used to explore the web efficiently.

---

## Network Discovery

Computers connected through networks form graphs.

Traversal algorithms help:

* Discover devices
* Detect connectivity issues
* Build routing tables

---

# Complexity Analysis

## Time Complexity

O(V + E)

Where:

* V = Vertices
* E = Edges

Every vertex is visited once.

Every edge is examined once.

---

## Space Complexity

O(V)

Used by:

* Queue
* Visited array

---

# Key Takeaways

This lab helped me learn:

* Swift classes
* Encapsulation
* Arrays
* Error handling
* Graph representation
* BFS traversal
* Algorithm complexity analysis

Most importantly, it showed how data structures and algorithms connect directly to real-world software systems rather than existing only as academic exercises.
