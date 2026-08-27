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
            name: "Infinite Apple Foundation Integration",
            targets: ["Infinite Apple Foundation Integration"]
        ),
        .library(
            name: "Infinite Test Support",
            targets: ["Infinite Test Support"]
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
            name: "Infinite Apple Foundation Integration",
            dependencies: ["Infinite"]
        ),
        .target(
            name: "Infinite Test Support",
            dependencies: ["Infinite"],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Infinite Tests",
            dependencies: [
                "Infinite",
                "Infinite Test Support",
            ]
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
