// swift-tools-version:4.0
// Generated automatically by Perfect Assistant 2
// Date: 2018-04-10 12:36:26 +0000
import PackageDescription

let package = Package(
	name: "PerfectTemplate",
	products: [
		.executable(name: "PerfectTemplate", targets: ["PerfectTemplate"])
	],
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", "3.0.0"..<"4.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", "3.1.0"..<"4.0.0"),
        .package(url: "https://github.com/iamjono/SwiftMoment.git", "0.0.1"..<"4.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-RequestLogger.git", "3.0.0"..<"4.0.0")
	],
	targets: [
		.target(name: "PerfectTemplate", dependencies: ["PerfectMySQL", "PerfectHTTPServer", "SwiftMoment", "PerfectRequestLogger"])
	]
)
