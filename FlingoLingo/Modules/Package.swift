// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Umbrella",
            targets: [
                "Authorization",
                "UIComponents",
                "Decks",
                "Dictionary",
            ]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Authorization",
            dependencies: [
                "UIComponents"
            ]
        ),
        .target(
            name: "UIComponents",
            dependencies: [
            ]
        ),
		.target(
            name: "Decks",
            dependencies: [
                "UIComponents"
            ]
        ),
        .target(
            name: "Dictionary",
            dependencies: [
                "UIComponents"
            ]
        ),
    ]
)
