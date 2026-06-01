// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Exercise01-Observer-Pattern",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Exercise01-Observer-Pattern"
        ),
        .testTarget(
            name: "Exercise01-Observer-PatternTests",
            dependencies: ["Exercise01-Observer-Pattern"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
