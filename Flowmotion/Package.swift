// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Flowmotion",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "Flowmotion", targets: ["Flowmotion"]),
    ],
    targets: [
        .target(name: "Flowmotion"),
    ]
)
