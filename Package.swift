// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DeirdreDevPublish",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(
            name: "DeirdreDevPublish",
            targets: ["DeirdreDevPublish"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(name: "TwitterPublishPlugin", url: "https://github.com/insidegui/TwitterPublishPlugin.git", from: "0.1.0")
//        .package(url: "https://github.com/thomaslupo/GistPublishPlugin", from: "0.1.0"),
//        .package(url: "https://github.com/finestructure/ImageAttributesPublishPlugin", from: "0.1.1")
    ],
    targets: [
        .target(
            name: "DeirdreDevPublish",
            dependencies: ["Publish", "TwitterPublishPlugin"
                           // ,                 "ImageAttributesPublishPlugin"

            ]
        ),
        .testTarget(
            name: "DeirdreDevPublishTests",
            dependencies: ["DeirdreDevPublish"]
        )
    ]
)
