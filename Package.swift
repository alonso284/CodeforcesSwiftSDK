// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CodeforcesSwiftSDK",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "Codeforces",
            targets: ["Codeforces"]
        ),
    ],
    targets: [
        .target(
            name: "Codeforces",
            path: "Codeforces",
            exclude: ["Codeforces.docc"]
        ),
        .testTarget(
            name: "CodeforcesTests",
            dependencies: ["Codeforces"],
            path: "CodeforcesTests"
        ),
    ]
)
