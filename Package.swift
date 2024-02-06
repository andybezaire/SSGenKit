// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SSGenKit",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(name: "SSGenKit", targets: ["SSGenKit"]),
        .library(name: "SSGenKitExtensions", targets: ["SSGenKitExtensions"]),
    ],
    targets: [
        .target(name: "SSGenKit"),
        .testTarget(name: "SSGenKitTests", dependencies: ["SSGenKit"]),
        .target(name: "SSGenKitExtensions"),
    ]
)
