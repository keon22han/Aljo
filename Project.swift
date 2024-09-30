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
                    "LSApplicationQueriesSchemes": [
                        "kakaokompassauth",
                        "kakaolink",
                        "kakaoplus"
                    ],
                    "CFBundleURLTypes": [
                        [
                            "CFBundleTypeRole": "Editor",
                            "CFBundleURLSchemes": [
                                "58129b7f325962454720eda35319bd48"
                            ]
                        ]
                    ]
                ]
            ),
            sources: ["Aljo/Sources/**"],
            resources: ["Aljo/Resources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture"),
                .external(name: "KakaoSDKAuth"),
                .external(name: "KakaoSDKCommon"),
                .external(name: "KakaoSDKUser"),
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
