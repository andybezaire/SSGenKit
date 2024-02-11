// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SSGenKit",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(name: "SSGenKit", targets: ["SSGenKit"]),
        .library(name: "SSGenKitExtensions", targets: ["SSGenKitExtensions"]),
    ],
    dependencies: [
      .package(
        url: "https://github.com/pointfreeco/swift-snapshot-testing",
        from: "1.12.0"
      ),
    ],
    targets: [
        .target(name: "SSGenKit"),
        .testTarget(
            name: "SSGenKitTests",
            dependencies: [
                "SSGenKit",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(name: "SSGenKitExtensions"),
    ]
)
