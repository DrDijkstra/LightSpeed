// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LightSpeedCore",
    platforms: [
        .iOS(.v13) // Adjust this based on your minimum deployment target
    ],
    products: [
        .library(
            name: "LightSpeedCore",
            targets: ["LightSpeedCore"]
        )
    ],
    dependencies: [
        // Alamofire dependency
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
        // XCoordinator dependency
        .package(url: "https://github.com/quickbirdstudios/XCoordinator.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "LightSpeedCore",
            dependencies: [
                "Alamofire",
                "XCoordinator"
            ]
        ),
        .testTarget(
            name: "LightSpeedCoreTests",
            dependencies: ["LightSpeedCore"]
        )
    ]
)
