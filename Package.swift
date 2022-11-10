// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DJSwiftHelpers",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DJSwiftHelpers",
            targets: ["DJSwiftHelpers", "DJSwiftHelpers_UIKit", "DJSwiftHelpers_SwiftUI"]
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
            path: "Sources/UIKit/",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "DJSwiftHelpers_SwiftUI",
            path: "Sources/SwiftUI/",
            linkerSettings: [
                .linkedFramework("SwiftUI")
            ]
        )
    ]
)
