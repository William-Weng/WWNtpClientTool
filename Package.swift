// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWNtpClientTool",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(name: "WWNtpClientTool", targets: ["WWNtpClientTool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWNtpClient", .upToNextMinor(from: "1.0.3"))
    ],
    targets: [
        .target(name: "WWNtpClientTool",
                dependencies: [
                    .product(name: "WWNtpClient", package: "WWNtpClient")
                ],
                resources: [.copy("Privacy")]),
    ],
    swiftLanguageModes: [
        .v6
    ]
)
