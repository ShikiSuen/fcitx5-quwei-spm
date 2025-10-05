// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "fcitx5-quwei-spm",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Quwei",
            type: .dynamic,
            targets: ["Quwei"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // Note: These are placeholder URLs - actual fcitx5 Swift packages would need to be created
        // or system libraries would need to be linked via system library targets
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Quwei",
            dependencies: [],
            cSettings: [
                .headerSearchPath("."),
            ],
            linkerSettings: [
                // Link against fcitx5 system libraries
                .linkedLibrary("Fcitx5Core"),
                .linkedLibrary("Fcitx5Module"),
                .linkedLibrary("iconv"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
