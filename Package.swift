// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "SolidStateDemo",
    products: [
        .library(
            name: "SolidStateDemo",
            targets: ["SolidStateDemo"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "SolidStateDemo",
            dependencies: ["Publish"]
        ),
        .testTarget(
            name: "SolidStateDemoTests",
            dependencies: ["SolidStateDemo"]
        )
    ]
)
