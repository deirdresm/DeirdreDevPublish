// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DeirdreDevPublish",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "DeirdreDevPublish",
            targets: ["DeirdreDevPublish"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "DeirdreDevPublish",
            dependencies: ["Publish"]
        ),
        .testTarget(
            name: "DeirdreDevPublishTests",
            dependencies: ["DeirdreDevPublish"]
        )
    ]
)
