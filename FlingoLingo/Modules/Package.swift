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
                "UserProfile",
                "Decks",
                "Dictionary",
                "NetworkLayer",
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/andriyslyusar/SwiftyKeychainKit.git", from: "1.0.0-beta.2"),
        .package(url: "https://github.com/CSolanaM/SkeletonUI.git", from: "1.0.11")
    ],
    targets: [
        .target(
            name: "Authorization",
            dependencies: [
                "UIComponents",
                "NetworkLayer"
            ]
        ),
        .target(
            name: "UIComponents",
            dependencies: [
            ]
        ),
        .target(
            name: "UserProfile",
            dependencies: [
                "UIComponents",
                "Authorization",
                    .product(name: "SkeletonUI", package: "SkeletonUI")
            ]
        ),
        .target(
            name: "Decks",
            dependencies: [
                "UIComponents",
                "NetworkLayer"
            ]
        ),
        .target(
            name: "Dictionary",
            dependencies: [
                "UIComponents",
                "NetworkLayer",
                "Decks"
            ]
        ),
        .target(
            name: "NetworkLayer",
            dependencies: [
                "UIComponents",
                    .product(name: "SwiftyKeychainKit", package: "SwiftyKeychainKit")
            ]
        ),
    ]
)
