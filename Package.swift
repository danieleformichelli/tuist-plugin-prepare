// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tuist-prepare",
    platforms: [.macOS(.v11)],
    products: [
        .executable(
            name: "tuist-prepare",
            targets: ["TuistPluginPrepare"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core", from: "0.2.5"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
        
    ],
    targets: [
        .executableTarget(
            name: "TuistPluginPrepare",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "TuistPluginPrepareFramework",
            ]
        ),
        .target(
            name: "TuistPluginPrepareFramework",
            dependencies: [
                .product(name: "TSCBasic", package: "swift-tools-support-core"),
            ]
        ),
    ]
)
