// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lab02-World-Travel-Planner",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Lab02-World-Travel-Planner"
        ),
        .testTarget(
            name: "Lab02-World-Travel-PlannerTests",
            dependencies: ["Lab02-World-Travel-Planner"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
