// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "LocalizationKit",
    defaultLocalization: "en", //Default language set to English
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "LocalizationKit",
            targets: ["LocalizationKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LocalizationKit",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "LocalizationKitTests",
            dependencies: ["LocalizationKit"]
        ),
    ]
)
