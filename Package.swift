// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NXFit",
    platforms: [.iOS(.v16), .watchOS(.v9)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NXFit",
            targets: ["NXFit"]),
        .library(
            name: "NXFitManagers",
            targets: ["NXFitManagers"]),
        .library(
            name: "NXFitRepositories",
            targets: ["NXFitRepositories"]),
        .library(
            name: "NXFitSync",
            targets: ["NXFitSync"]),
    ],
    dependencies: [.package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NXFit",
            dependencies: ["NXFitAuth", "NXFitCommon", "NXFitConfig", "NXFitConnectivity", "NXFitModels", "NXFitServices", .product(name: "Logging", package: "swift-log")],
            path: "NXFit/Sources",
        ),
        .target(
            name: "NXFitAuth",
            dependencies: ["NXFitCommon", .product(name: "Logging", package: "swift-log")],
            path: "NXFitAuth/Sources"
        ),
        .target(
            name: "NXFitCommon",
            dependencies: [.product(name: "Logging", package: "swift-log")],
            path: "NXFitCommon/Sources"
        ),
        .target(
            name: "NXFitConfig",
            path: "NXFitConfig/Sources"
        ),
        .target(
            name: "NXFitConnectivity",
            dependencies: ["NXFitCommon", .product(name: "Logging", package: "swift-log")],
            path: "NXFitConnectivity/Sources"
        ),
        .target(
            name: "NXFitManagers",
            dependencies: ["NXFitAuth", "NXFitCommon", "NXFitConfig", "NXFitModels", "NXFitServices", .product(name: "Logging", package: "swift-log")],
            path: "NXFitManagers/Sources"
        ),
        .target(
            name: "NXFitModels",
            dependencies: ["NXFitCommon"],
            path: "NXFitModels/Sources"
        ),
        .target(
            name: "NXFitRepositories",
            dependencies: ["NXFit", "NXFitCommon", "NXFitConfig", "NXFitConnectivity", "NXFitModels", "NXFitServices"],
            path: "NXFitRepositories/Sources"
        ),
        .target(
            name: "NXFitServices",
            dependencies: ["NXFitCommon", "NXFitConfig", "NXFitModels", .product(name: "Logging", package: "swift-log")],
            path: "NXFitServices/Sources"
        ),
        .target(
            name: "NXFitSync",
            dependencies: ["NXFitAuth", "NXFitCommon", "NXFitConfig", "NXFitConnectivity", "NXFitModels", "NXFitServices"],
            path: "NXFitSync/Sources"
        ),
    ]
)
