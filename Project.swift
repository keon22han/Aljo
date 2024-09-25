import ProjectDescription

let project = Project(
    name: "Aljo",
    targets: [
        .target(
            name: "Aljo",
            destinations: .iOS,
            product: .app,
            bundleId: "com.asap.Aljo",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Aljo/Sources/**"],
            resources: ["Aljo/Resources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "AljoTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.AljoTests",
            infoPlist: .default,
            sources: ["Aljo/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Aljo")]
        ),
    ]
)
