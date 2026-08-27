// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-infinite",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Infinite",
            targets: ["Infinite"]
        ),
        .library(
            name: "Infinite Standard Library Integration",
            targets: ["Infinite Standard Library Integration"]
        ),
        .library(
            name: "Infinite Apple Foundation Integration",
            targets: ["Infinite Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "Infinite",
            dependencies: [
                .product(name: "Iterator", package: "swift-iterator")
            ]
        ),
        .target(
            name: "Infinite Standard Library Integration",
            dependencies: ["Infinite"]
        ),
        .target(
            name: "Infinite Apple Foundation Integration",
            dependencies: [
                "Infinite",
                "Infinite Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Infinite Tests",
            dependencies: ["Infinite"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
