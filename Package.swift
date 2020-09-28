// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LogManager",
    platforms: [ .iOS(.v9) ],
    products: [
        .library(
            name: "LogManager",
            targets: ["LogManager"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LogManager",
            dependencies: []),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
