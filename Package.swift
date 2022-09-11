// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "DeirdreDevPublish",
    platforms: [
		.macOS(.v12),
    ],
    products: [
        .executable(
            name: "DeirdreDevPublish",
            targets: ["DeirdreDevPublish"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(name: "TwitterPublishPlugin", url: "https://github.com/deirdresm/TwitterPublishPlugin.git", from: "0.1.1"),
		.package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.2.0"),
//		.package(url: "https://github.com/deirdresm/ImageAttributesPublishPlugin", from: "0.1.2")

//        .package(url: "https://github.com/thomaslupo/GistPublishPlugin", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "DeirdreDevPublish",
            dependencies: ["Publish",
						   "TwitterPublishPlugin",
						   "SplashPublishPlugin"
//						   ,"ImageAttributesPublishPlugin"
            ]
        ),
        .testTarget(
            name: "DeirdreDevPublishTests",
            dependencies: ["DeirdreDevPublish"]
        )
    ]
)
