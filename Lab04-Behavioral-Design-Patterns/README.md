# Lab 04 - Behavioral Design Patterns in Swift

## Overview

This lab explores two fundamental behavioral design patterns:

* Observer Pattern
* Strategy Pattern

The original assignment was designed for Java as part of an Advanced Object-Oriented Programming course. I reimplemented the exercises in Swift to better understand how object-oriented design principles translate into modern Swift development.

The goal of this lab is not only to implement the patterns, but also to understand the design problems they solve, how they improve maintainability, and where they are used in real software systems.

---

# Learning Objectives

Through this lab, I aimed to:

* Understand behavioral design patterns
* Apply SOLID principles in practice
* Replace tightly coupled designs with flexible architectures
* Learn how Swift protocols replace Java interfaces
* Practice dependency inversion and composition
* Build systems that are easier to extend without modification

---

# Exercises

## Exercise 01 - Observer Pattern

### Problem

The original stock market application directly depended on:

* DashboardDisplay
* AlertSystem
* TradeLogger

Whenever a stock price changed, the StockMarket class manually notified each component.

This design caused several problems:

* Tight coupling
* Open/Closed Principle violations
* Difficult extensibility
* Growing dependency management

Adding a new notification system required modifying the StockMarket class.

---

### Refactoring

The solution was to introduce a common observer abstraction.

```text
StockMarket
      |
      v
StockObserver
      |
 ┌────┼────┬─────────┐
 |    |    |         |
 v    v    v         v

Dashboard
Alert
Logger
Mobile Push
```

The StockMarket now publishes events while observers decide how to react.

---

### Swift Concepts Practiced

* Protocols
* Dependency Inversion
* Composition
* Polymorphism
* Observer Pattern

---

### Key Takeaway

The subject no longer needs to know who is listening.

New observers can be added without changing existing code.

---

# Exercise 02 - Strategy Pattern

### Problem

The original delivery pricing system contained a large if-else chain.

```text
Standard Pricing
Express Pricing
Scheduled Pricing
```

All pricing algorithms lived inside a single method.

This made the calculator difficult to maintain and extend.

Adding a new delivery type required modifying existing code.

---

### Refactoring

Each pricing algorithm was extracted into its own strategy.

```text
DeliveryPriceCalculator
           |
           v

DeliveryPricingStrategy
           |
  ┌────────┼─────────┬──────────┐
  |        |         |          |
  v        v         v          v

Standard  Express  Scheduled  Subscription
```

The calculator delegates pricing decisions to the selected strategy.

---

### Swift Concepts Practiced

* Protocol-Oriented Design
* Dependency Injection
* Runtime Behavior Switching
* Open/Closed Principle
* Strategy Pattern

---

### Key Takeaway

The calculator no longer needs to know how every pricing algorithm works.

New pricing models can be introduced without modifying existing code.

---

# Java to Swift Mapping

One of the goals of this repository is understanding how familiar Java design concepts translate into Swift.

| Java                 | Swift                 |
| -------------------- | --------------------- |
| Interface            | Protocol              |
| Observer Interface   | Observer Protocol     |
| Strategy Interface   | Strategy Protocol     |
| Dependency Injection | Dependency Injection  |
| Runtime Polymorphism | Protocol Dispatch     |
| Composition          | Composition           |
| Abstract Behavior    | Protocol Requirements |

Understanding these mappings helps build stronger language-independent design skills.

---

# SOLID Principles Practiced

## Single Responsibility Principle

Each class has one responsibility.

Examples:

* DashboardObserver displays updates
* AlertObserver generates alerts
* TradeLoggerObserver records changes

---

## Open Closed Principle

New behavior can be added without modifying existing classes.

Examples:

* MobilePushObserver
* SubscriptionPricing

Both were added without changing core system classes.

---

## Liskov Substitution Principle

Any observer can replace another observer.

Any pricing strategy can replace another strategy.

---

## Interface Segregation Principle

Protocols expose only the behavior clients actually need.

---

## Dependency Inversion Principle

High-level modules depend on abstractions rather than concrete implementations.

---

# Real World Applications

These patterns appear frequently in production software.

---

## Observer Pattern

Used in:

* SwiftUI State Updates
* NotificationCenter
* Event Systems
* Push Notification Pipelines
* Analytics Tracking

Example:

When application state changes, multiple UI components automatically update.

---

## Strategy Pattern

Used in:

* Payment Methods
* Authentication Providers
* Sorting Algorithms
* Network Retry Policies
* Pricing Engines

Example:

An app can switch between different payment providers without changing checkout logic.

---

# Folder Structure

```text
Lab04-Behavioral-Design-Patterns/

├── Exercise01-Observer-Pattern/
│   ├── Sources/
│   └── README.md
│
├── Exercise02-Strategy-Pattern/
│   ├── Sources/
│   └── README.md
│
└── README.md
```

Each exercise contains:

* Swift implementation
* Pattern-specific classes
* Test examples
* Documentation

---

# What I Learned

This lab helped me understand that design patterns are not about memorizing diagrams.

They are reusable solutions to common software design problems.

The Observer Pattern showed how systems can communicate without becoming tightly coupled.

The Strategy Pattern demonstrated how behavior can be changed dynamically without modifying existing code.

Most importantly, I learned how Swift protocols enable many of the same design techniques traditionally taught using Java interfaces.

These concepts form the foundation of scalable and maintainable software architecture and appear throughout modern iOS development.

---

# Conclusion

This lab focused on improving software design rather than adding new functionality.

By applying Observer and Strategy patterns, the systems became:

* More flexible
* More extensible
* Easier to maintain
* Better aligned with SOLID principles

The experience reinforced an important lesson:

Good software design is not about making code work—it is about making code easy to change.
