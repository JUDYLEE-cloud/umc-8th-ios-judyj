import ProjectDescription

let project = Project(
    name: "StarbucksCloneTuist",
    targets: [
        .target(
            name: "StarbucksCloneTuist",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.StarbucksCloneTuist",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["StarbucksCloneTuist/Sources/**"],
            resources: ["StarbucksCloneTuist/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "StarbucksCloneTuistTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.StarbucksCloneTuistTests",
            infoPlist: .default,
            sources: ["StarbucksCloneTuist/Tests/**"],
            resources: [],
            dependencies: [.target(name: "StarbucksCloneTuist")]
        ),
    ]
)
