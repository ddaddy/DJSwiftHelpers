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
            name: "DJSwiftHelpers_UIKit",
            targets: ["DJSwiftHelpers_UIKit"]
        ),
        .library(
            name: "DJSwiftHelpers_SwiftUI",
            targets: ["DJSwiftHelpers_SwiftUI"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DJSwiftHelpers",
            path: "Sources/Common/"
        ),
        .target(
            name: "DJSwiftHelpers_UIKit",
            path: "Sources/Non_Extension/"
        ),
        .target(
            name: "DJSwiftHelpers_SwiftUI",
            path: "Sources/SwiftUI/"
        )
    ]
)
