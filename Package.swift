// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "fcitx5-quwei-spm",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Quwei",
            type: .dynamic,
            targets: ["Quwei"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // C++ wrapper target for FCITX5 imports
        // This target manages all FCITX5 C++ interop, allowing different input method projects
        // to customize their FCITX5 component dependencies
        .target(
            name: "CFcitx5Imports",
            dependencies: [],
            publicHeadersPath: "include",
            cxxSettings: [
                .headerSearchPath("include"),
            ],
            linkerSettings: [
                // Link against fcitx5 system libraries
                // NOTE: Uncomment these when FCITX5 libraries are installed on your system:
                // .linkedLibrary("Fcitx5Core"),
                // .linkedLibrary("Fcitx5Module"),
                // .linkedLibrary("iconv"),
            ]
        ),
        
        // Swift implementation of Quwei input method
        .target(
            name: "Quwei",
            dependencies: ["CFcitx5Imports"],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        ),
        
        // Swift Testing target
        .testTarget(
            name: "QuweiTests",
            dependencies: ["Quwei"],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        ),
    ],
    cxxLanguageStandard: .cxx17
)
