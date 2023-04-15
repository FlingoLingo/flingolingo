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
                "UserProfile",
                "UIComponents"
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
            dependencies: []),
        .target(
            name: "UserProfile",
            dependencies: [
                "UIComponents"
            ])
    ]
)
