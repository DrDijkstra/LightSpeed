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
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
        .package(url: "https://github.com/quickbirdstudios/XCoordinator.git", from: "2.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/chiahsien/CHTCollectionViewWaterfallLayout.git", from: "0.9.9")
    ],
    targets: [
        .target(
            name: "LightSpeedCore",
            dependencies: [
                "Alamofire",
                "XCoordinator",
                "Kingfisher",
                "CHTCollectionViewWaterfallLayout"
            ],
            resources: [.process("LightSpeedCore.xcdatamodeld")]

        ),
        .testTarget(
            name: "LightSpeedCoreTests",
            dependencies: ["LightSpeedCore"]
        )
    ]
)
