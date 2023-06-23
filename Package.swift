// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoursesKit",
    platforms: [
      .macOS(.v13),
      .iOS(.v16)
    ],
    products: [
      .library(name: "AddEventFeature", targets: ["AddEventFeature"]),
      .library(name: "CourseClient", targets: ["CourseClient"]),
      .library(name: "CourseClientLive", targets: ["CourseClientLive"]),
      .library(name: "CourseDetailFeature", targets: ["CourseDetailFeature"]),
      .library(name: "CourseListFeature", targets: ["CourseListFeature"]),
      .library(name: "Model", targets: ["Model"]),
      .library(name: "SiteRouter", targets: ["SiteRouter"]),
    ],
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.54.1"),
      .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
      .package(url: "https://github.com/pointfreeco/vapor-routing", from: "0.1.0"),
      .package(url: "https://github.com/pointfreeco/swift-url-routing.git", from: "0.5.0"),
      .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
    ],
    targets: [
      .target(
        name: "AddEventFeature",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
          "Model",
        ],
        path: "Sources/Client/AddEventFeature"
      ),
      .target(
        name: "CourseClient",
        dependencies: [
          .product(name: "Dependencies", package: "swift-dependencies"),
          "Model",
          "SiteRouter",
        ],
        path: "Sources/Client/CourseClient"
      ),
      .testTarget(
        name: "CourseClientTests",
        dependencies: [
          "CourseClient",
          .product(name: "Dependencies", package: "swift-dependencies"),
          "SiteRouter"
        ]
      ),
      .target(
        name: "CourseClientLive",
        dependencies: ["CourseClient"],
        path: "Sources/Client/CourseClientLive"
      ),
      .target(
        name: "CourseDetailFeature",
        dependencies: [
          "AddEventFeature",
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
          "CourseClient",
          "Model",
        ],
        path: "Sources/Client/CourseDetailFeature"
      ),
      .target(
        name: "CourseListFeature",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
          "CourseClient",
          "CourseDetailFeature",
          "Model"
        ],
        path: "Sources/Client/CourseListFeature"
      ),
      .target(
        name: "Model",
        path: "Sources/Shared/Model"
      ),
      .executableTarget(
        name: "Server",
        dependencies: [
          .product(name: "Dependencies", package: "swift-dependencies"),
          "Model",
          "SiteRouter",
          .product(name: "Vapor", package: "vapor"),
          .product(name: "VaporRouting", package: "vapor-routing")
        ],
        swiftSettings: [
          // Enable better optimizations when building in Release configuration. Despite the use of
          // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
          // builds. See <https://www.swift.org/server/guides/building.html#building-for-production> for details.
          .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
        ]
      ),
      .testTarget(name: "ServerTests", dependencies: [
        .target(name: "Server"),
        "Model",
        .product(name: "XCTVapor", package: "vapor"),
      ]),
      .target(
        name: "SiteRouter",
        dependencies: [
          "Model",
          .product(name: "URLRouting", package: "swift-url-routing"),
        ],
        path: "Sources/Shared/SiteRouter"
      ),
    ]
)
