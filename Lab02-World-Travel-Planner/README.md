# Lab 02 - World Travel Planner using DFS and Immutability in Swift

## Overview

This lab explores graph traversal using Depth First Search (DFS) and introduces one of the most important software engineering concepts: immutability.

The application models a network of world cities connected through flights.

Cities are represented as immutable objects, while flight routes form a graph.

The system uses DFS to discover a travel route from one city to another.

---

# Problem Statement

Build a travel planning system that:

* Stores cities as immutable objects
* Represents flight routes as a graph
* Uses DFS to find a route between cities
* Prevents cycles during traversal
* Handles invalid input safely

---

# Swift Concepts Practiced

## Immutability

The City model uses constants.

```swift
let name: String
let country: String
let timezone: String
```

After creation, these values cannot change.

Example:

```swift
let tokyo = City(...)
```

Its properties remain fixed forever.

---

## Why Immutability Matters

Mutable objects can change unexpectedly.

Example:

```swift
city.name = "Paris"
```

If other parts of the system depend on that value, bugs appear.

Immutable objects eliminate this category of problems.

---

## Real Engineering Use Cases

Immutability is heavily used in:

### SwiftUI

SwiftUI rebuilds UI from immutable state snapshots.

### Concurrent Programming

Multiple threads can safely read immutable data.

### Financial Systems

Transaction records should never change after creation.

### Distributed Systems

Immutable data is easier to cache and synchronize.

---

# Hashable

The graph stores cities inside a dictionary.

```swift
[City : [City]]
```

Dictionary keys must conform to Hashable.

```swift
final class City: Hashable
```

This allows Swift to efficiently locate cities.

---

# Equatable

Two cities are considered equal if their names match.

```swift
static func == (...)
```

This defines logical equality.

---

# CustomStringConvertible

Provides human-readable output.

```swift
print(city)
```

Output:

```text
City{name='Tokyo', country='Japan', timezone='JST'}
```

This improves debugging and logging.

---

# Dictionaries

The graph uses:

```swift
[City : [City]]
```

Equivalent Java structure:

```java
Map<City, List<City>>
```

Dictionary lookup is approximately:

```text
O(1)
```

making graph operations efficient.

---

# Sets

Visited cities are tracked using:

```swift
Set<City>
```

Benefits:

* Fast lookup
* No duplicates
* Efficient cycle prevention

---

# Depth First Search (DFS)

DFS explores as deeply as possible before backtracking.

Algorithm:

1. Start from source city
2. Move to one connected city
3. Continue deeper
4. Backtrack when necessary
5. Stop when destination is found

---

# Why DFS Uses a Stack

DFS requires Last In First Out behavior.

Swift stack implementation:

```swift
var stack: [City]
```

Push:

```swift
stack.append(city)
```

Pop:

```swift
stack.removeLast()
```

---

# DFS Traversal Example

```text
New York
|
Tokyo
|
Singapore
|
Dubai
```

Possible route:

```text
New York → Tokyo → Singapore → Dubai
```

DFS follows one path deeply before exploring alternatives.

---

# DFS vs BFS

## DFS

Uses:

```text
Stack
```

Behavior:

```text
Go Deep
```

Advantages:

* Lower memory usage
* Simple path exploration

Limitations:

* Does not guarantee shortest path

---

## BFS

Uses:

```text
Queue
```

Behavior:

```text
Explore Level by Level
```

Advantages:

* Finds shortest path in unweighted graphs

Limitations:

* Uses more memory

---

# Real Engineering Applications

## Route Planning

Transportation systems:

* Airlines
* Railways
* Metro networks

can be represented as graphs.

---

## Dependency Resolution

Package managers:

* Swift Package Manager
* npm
* Maven

traverse dependency graphs.

---

## File System Exploration

Folders and files form tree structures.

DFS is commonly used to:

* Search files
* Calculate directory sizes
* Traverse folders recursively

---

## Game Development

Many games use DFS for:

* Maze solving
* Path exploration
* Puzzle generation

---

# Error Handling

The implementation validates:

* Empty city names
* Null-like invalid values
* Missing cities
* Invalid route requests

Swift error handling:

```swift
throw
```

```swift
try
```

```swift
catch
```

provides safer failure handling than many traditional approaches.

---

# Complexity Analysis

## Time Complexity

O(V + E)

Where:

* V = Cities
* E = Flight Connections

---

## Space Complexity

O(V)

Used by:

* Stack
* Visited Set
* Parent Tracking

---

# Software Engineering Lessons

This lab goes beyond graph traversal.

It demonstrates:

* Immutability
* Safe object design
* Encapsulation
* Hashing
* Equality
* Graph modeling
* Path finding

These concepts appear frequently in production Swift applications, backend systems, distributed systems, and large-scale software architecture.

The biggest takeaway from this lab is understanding that data structures are not isolated academic topics. Graphs, stacks, and immutable models are used daily in real software products serving millions of users.
