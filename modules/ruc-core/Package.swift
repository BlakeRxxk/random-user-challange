// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ruc-core",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "RUCCore", targets: ["RUCCore"]),
        .library(name: "RUCNetwork", targets: ["RUCNetwork"]),
    ],
    targets: [
        .target(name: "RUCCore"),
        .target(name: "RUCNetwork"),
        .testTarget(
            name: "RUCCoreTests",
            dependencies: ["RUCCore"],
        ),
    ],
)
