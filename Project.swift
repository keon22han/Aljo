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
                                "kakaof69b66f3ed673e7faad06d12743915e4"
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
