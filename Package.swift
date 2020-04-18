// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "SwiftyPodsDSL",
    products: [
        .library(
            name: "SwiftyPodsDSL",
            targets: ["SwiftyPodsDSL"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftyPodsDSL",
            dependencies: []),
        .testTarget(
            name: "SwiftyPodsDSLTests",
            dependencies: ["SwiftyPodsDSL"]),
    ]
)
