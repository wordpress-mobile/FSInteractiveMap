// swift-tools-version:5.10

import Foundation
import PackageDescription

let package = Package(
    name: "FSInteractiveMap",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "FSInteractiveMap", targets: ["FSInteractiveMap"])
    ],
    targets: [
        .target(name: "FSInteractiveMap")
    ]
)
