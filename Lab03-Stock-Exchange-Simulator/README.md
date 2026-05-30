# Lab 03 - Concurrent Stock Exchange Simulator

## Overview

This lab is a Swift implementation of a simplified stock trading exchange inspired by a Java concurrency assignment from an Advanced Object-Oriented Programming course.

The goal of the project is to simulate how a stock exchange processes buy and sell orders concurrently. Multiple traders continuously generate orders, an order book stores pending orders, a matching engine executes trades, and a dashboard displays live exchange statistics.

Unlike the previous graph-based labs, this project focuses heavily on concurrency, synchronization, thread safety, producer-consumer architecture, and coordinated shutdown of concurrent systems.

---

# Problem Statement

Build a simplified stock exchange that:

* Accepts buy and sell orders from multiple traders
* Stores pending orders in a shared order book
* Matches compatible buy and sell orders
* Executes trades automatically
* Maintains live market statistics
* Displays a real-time dashboard
* Supports safe concurrent access from multiple threads
* Shuts down gracefully without deadlocks or hanging threads

---

# Project Architecture

```text
                 ┌─────────────┐
                 │   Trader 1  │
                 └──────┬──────┘
                        │

                 ┌─────────────┐
                 │   Trader 2  │
                 └──────┬──────┘
                        │

                 ┌─────────────┐
                 │   Trader N  │
                 └──────┬──────┘
                        │

                        ▼

             ┌─────────────────────┐
             │      OrderBook      │
             └─────────┬───────────┘
                       │

                       ▼

             ┌─────────────────────┐
             │   Matching Engine   │
             └─────────┬───────────┘
                       │

                       ▼

             ┌─────────────────────┐
             │   Exchange Stats    │
             └─────────┬───────────┘
                       │

                       ▼

             ┌─────────────────────┐
             │      Dashboard      │
             └─────────────────────┘
```

---

# Swift Concepts Practiced

## Structs and Immutability

Orders and matched trades are represented using immutable models.

```swift
struct Order
```

```swift
struct MatchedPair
```

All properties use:

```swift
let
```

Once an order is created, it cannot be modified.

### Why This Matters

Immutable objects are naturally thread-safe.

Multiple threads can safely read the same order without synchronization because the data never changes.

This is a common practice in:

* Financial systems
* Distributed systems
* Event-driven architectures
* SwiftUI state management

---

## Enumerations

Order types are represented using enums.

```swift
enum OrderType {
    case buy
    case sell
}
```

Enums provide stronger type safety than using strings.

Benefits:

* Prevent invalid values
* Improve code readability
* Reduce runtime errors

---

## Extensions

Swift extensions are used to add functionality without modifying the original type.

Example:

```swift
extension Order: CustomStringConvertible
```

This allows clean printing and debugging.

Extensions are heavily used throughout Apple's frameworks.

---

## Value Types vs Reference Types

This project intentionally uses both:

### Structs

```swift
Order
MatchedPair
```

Used for immutable data.

### Classes

```swift
OrderBook
Trader
MatchingEngine
ExchangeStats
Dashboard
```

Used when shared mutable state is required.

Understanding when to use structs versus classes is one of the most important Swift design decisions.

---

# Concurrency Concepts

This lab introduces several important concurrency concepts.

---

## Shared State

Multiple traders interact with the same order book simultaneously.

Without synchronization, race conditions could occur.

Example:

```text
Trader A adds an order
Trader B removes an order
Matching Engine scans orders

All at the same time
```

Shared mutable state must be protected.

---

## Locks

The OrderBook uses locking to ensure thread safety.

```swift
NSCondition
```

Only one thread can modify the order book at a time.

Benefits:

* Prevents data corruption
* Ensures consistent state
* Avoids race conditions

---

## Condition Variables

The OrderBook uses conditions to coordinate producers and consumers.

### Producers

```text
Traders
```

create orders.

### Consumer

```text
Matching Engine
```

consumes orders.

Threads can:

```swift
wait()
```

until work becomes available.

Other threads can:

```swift
signal()
```

to wake them.

---

## Producer Consumer Pattern

This entire project follows the producer-consumer architecture.

### Producers

```text
Traders
```

Generate orders.

### Consumer

```text
Matching Engine
```

Processes orders.

This pattern appears in:

* Message queues
* Backend services
* Kafka consumers
* RabbitMQ systems
* Trading platforms

---

## Task-Based Concurrency

Swift Tasks are used to run components concurrently.

```swift
Task { }
```

This is conceptually similar to:

```java
ExecutorService.submit()
```

in Java.

Tasks allow work to execute concurrently while maintaining structured control over execution.

---

# Core Components

---

## Order

Represents a buy or sell request.

Properties:

* Order ID
* Trader Name
* Order Type
* Stock Symbol
* Price
* Quantity
* Timestamp

Example:

```text
BUY TCS x15 @ ₹3520.00 [ORD-001 by Alice]
```

---

## MatchedPair

Represents a successful trade execution.

Contains:

* Buy Order
* Sell Order
* Execution Price
* Executed Quantity

Execution price is calculated as:

```text
(buyPrice + sellPrice) / 2
```

Executed quantity is:

```text
min(buyQuantity, sellQuantity)
```

---

## OrderBook

The central component of the exchange.

Responsibilities:

* Store buy orders
* Store sell orders
* Accept new orders
* Match compatible orders
* Coordinate producer and consumer threads

Matching Rule:

```text
Same Stock

AND

Buy Price >= Sell Price
```

---

## Trader

Simulates a market participant.

Responsibilities:

* Generate random orders
* Select random stocks
* Randomly choose buy or sell
* Submit orders continuously

Traders run concurrently and operate independently.

---

## Matching Engine

Consumes orders from the OrderBook.

Responsibilities:

* Find matching buy/sell pairs
* Execute trades
* Update statistics
* Print trade executions

The engine acts as the consumer in the system.

---

## ExchangeStats

Tracks exchange activity.

Maintains:

* Total Trades
* Total Volume
* Last Trade Price
* Highest Price
* Lowest Price

Provides consistent snapshots for reporting.

---

## Dashboard

Displays exchange activity periodically.

Example:

```text
===== EXCHANGE DASHBOARD =====

Trades: 42
Volume: 1180
Last: 3515.50
High: 3600.00
Low: 1400.00

Pending Orders: 21

==============================
```

The dashboard updates every few seconds while the exchange is running.

---

# Java to Swift Mapping

One of the goals of this repository is understanding how Java concepts translate into Swift.

| Java                     | Swift                      |
| ------------------------ | -------------------------- |
| Immutable Class          | Struct with let properties |
| Callable                 | Task                       |
| Future                   | Task.value                 |
| ExecutorService          | Task / TaskGroup           |
| ReentrantLock            | NSLock                     |
| Condition                | NSCondition                |
| ScheduledExecutorService | DispatchSourceTimer        |
| AtomicBoolean            | Shared State / Actor State |
| AtomicInteger            | Protected Counter          |
| Thread                   | Task / DispatchQueue       |

Understanding these mappings helps bridge object-oriented programming concepts across languages.

---

# Real World Applications

Although simplified, this project models several real-world systems.

---

## Stock Exchanges

Modern exchanges continuously:

* Receive orders
* Match buyers and sellers
* Execute trades
* Update market statistics

The architecture used in this lab mirrors these core ideas.

---

## E-Commerce Systems

Customers create orders while inventory systems process purchases concurrently.

Similar producer-consumer workflows are used.

---

## Ride Sharing Platforms

Drivers and passengers create requests.

Matching systems pair compatible participants.

The matching engine concept is similar.

---

## Distributed Job Processing

Workers consume tasks from a queue while producers continuously create work.

Examples:

* Background processing
* Notification systems
* Data pipelines

---

## Backend Services

Many backend architectures contain:

* Producers
* Shared queues
* Consumers
* Monitoring dashboards

The same concepts appear in this project.

---

# Complexity Analysis

## Order Insertion

Average Complexity:

```text
O(1)
```

Orders are appended to a list.

---

## Matching

Current implementation:

```text
O(B × S)
```

Where:

* B = Buy Orders
* S = Sell Orders

Every buy order may be compared against every sell order.

Production exchanges use specialized data structures to improve performance.

---

## Statistics Update

```text
O(1)
```

Each trade updates counters and prices directly.

---

# What I Learned

This lab significantly expanded my understanding of concurrent systems.

Before implementing this project, I mostly associated concurrency with simply running multiple threads.

While building the exchange simulator, I learned that the real challenge is coordinating access to shared state safely.

Key lessons include:

* Why immutable data is safer in concurrent systems
* How producer-consumer architectures work
* How locks prevent race conditions
* Why condition variables are necessary
* How scheduled tasks support monitoring systems
* How coordinated shutdown prevents hanging threads
* How concurrency concepts translate from Java to Swift

Most importantly, I learned that concurrency is not about creating more threads—it is about managing shared resources correctly.

---

# Future Improvements

Possible enhancements include:

* Priority-based order matching
* Partial order fulfillment
* Market orders
* Persistent storage
* Real-time graphical dashboard
* Actor-based implementation
* Async/Await only implementation
* Order cancellation support
* Multiple matching strategies

---

# Conclusion

This lab combines object-oriented design, concurrency, synchronization, and system architecture into a single project.

It demonstrates how multiple independent components can work together safely in a concurrent environment while maintaining correctness and responsiveness.

More importantly, it shows how concepts learned in an Advanced OOP course can be applied using modern Swift and used to understand the foundations of real-world software systems.
