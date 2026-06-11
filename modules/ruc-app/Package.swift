// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ruc-app",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "RUCApp", targets: ["RUCApp"]),
        .library(name: "UsersList", targets: ["UsersList"]),
        .library(name: "UserDetail", targets: ["UserDetail"]),
        .library(name: "RandomUserDomain", targets: ["RandomUserDomain"]),
        .library(name: "RandomUserData", targets: ["RandomUserData"]),
    ],
    dependencies: [
        .package(name: "RUCCore", path: "../ruc-core"),
        .package(name: "RUCUI", path: "../ruc-ui"),
    ],
    targets: [
        .target(
            name: "RUCApp",
            dependencies: [
                "UsersList",
                "RandomUserData",
                .product(name: "RUCNetwork", package: "RUCCore"),
                .product(name: "RUCCore", package: "RUCCore"),
            ],
        ),
        .target(
            name: "UsersList",
            dependencies: [
                "RUCUI",
                "UserDetail",
                "RandomUserDomain",
                .product(name: "RUCCore", package: "RUCCore"),
            ],
        ),
        .target(
            name: "UserDetail",
            dependencies: [
                "RUCUI",
                "RandomUserDomain",
                .product(name: "RUCCore", package: "RUCCore"),
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
