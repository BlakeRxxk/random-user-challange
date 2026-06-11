// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ruc-app",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "RUCApp", targets: ["RUCApp"]),
        .library(name: "UsersList", targets: ["UsersList"]),
        .library(name: "RandomUserDomain", targets: ["RandomUserDomain"]),
        .library(name: "RandomUserData", targets: ["RandomUserData"]),
    ],
    dependencies: [
        .package(name: "RUCCore", path: "../ruc-core"),
        .package(name: "RUCUI", path: "../ruc-ui"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RUCApp",
            dependencies: [
                "UsersList",
                .product(name: "RUCNetwork", package: "RUCCore"),
                .product(name: "RUCCore", package: "RUCCore"),
            ],
        ),
        .target(
            name: "UsersList",
            dependencies: [
                "RUCUI",
                "RandomUserDomain",
                "RandomUserData",
                .product(name: "RUCCore", package: "RUCCore"),
                .product(name: "RUCNetwork", package: "RUCCore"),
            ],
        ),
        .target(name: "RandomUserDomain"),
        .target(name: "RandomUserData", dependencies: [
            "RandomUserDomain",
            .product(name: "RUCCore", package: "RUCCore"),
            .product(name: "RUCNetwork", package: "RUCCore"),
        ]),
        .testTarget(
            name: "RUCAppTests",
            dependencies: ["RUCApp"],
        ),
    ],
)
