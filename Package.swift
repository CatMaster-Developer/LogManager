
import PackageDescription

let package = Package(
    name: "LogManager",
    platforms: [
        .iOS(.v10),
    ]
    products: [
        .library(
            name: "LogManager",
            targets: ["LogManager"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/CatMaster-Developer/LogManager.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "LogManager",
            dependencies: ["LogManager"]
        ),
    ]
)
