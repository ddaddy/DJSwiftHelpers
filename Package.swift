// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DJSwiftHelpers",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DJSwiftHelpers",
            targets: ["DJSwiftHelpers"]
        ),
        .library(
            name: "DJSwiftHelpers-Extension",
            targets: ["DJSwiftHelpers-Extension"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DJSwiftHelpers-Extension",
            path: "Sources/Common/"
        ),
        .target(
            name: "DJSwiftHelpers",
            path: "Sources/Non_Extension/",
            sources: ["../Common/", "../Non_Extension/"]
        )
    ]
)
