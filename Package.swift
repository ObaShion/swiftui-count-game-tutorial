// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "GameEffects",
    platforms: [
        .iOS(.v17),
        // Including macOS makes `swift build` validate the package on a Mac too.
        .macOS(.v14)
    ],
    products: [
        .library(name: "GameEffects", targets: ["GameEffects"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.5.0")
    ],
    targets: [
        .target(name: "GameEffects")
    ]
)
