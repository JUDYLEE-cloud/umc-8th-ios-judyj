import ProjectDescription

let project = Project(
    name: "StarbucksClone",
    targets: [
        .target(
            name: "StarbucksClone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.StarbucksClone",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["StarbucksClone/Sources/**"],
            resources: ["StarbucksClone/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "StarbucksCloneTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.StarbucksCloneTests",
            infoPlist: .default,
            sources: ["StarbucksClone/Tests/**"],
            resources: [],
            dependencies: [.target(name: "StarbucksClone")]
        ),
    ]
)
