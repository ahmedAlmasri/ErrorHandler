// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SNErrorHandler",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "SNErrorHandler",
                 targets: ["SNErrorHandler"]),
        .library(
            name: "RXSNErrorHandler",
            targets: ["RXSNErrorHandler"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.5.0"))
    ],
    targets: [
        .target(name: "SNErrorHandler",
                path: "ErrorHandler/Core"),
        
        .target(name: "RXSNErrorHandler",
                 dependencies: ["SNErrorHandler", "RxSwift", "RxCocoa"],
                path: "ErrorHandler/Rx"),
        .testTarget(
            name: "SNErrorHandlerTests",
            dependencies: ["SNErrorHandler", "RXSNErrorHandler", "RxSwift", "RxCocoa", "RxBlocking", "RxTest"],
            path: "Example/Tests"),
    ],
    swiftLanguageVersions: [.v5]

)
