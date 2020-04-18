![Swift](https://github.com/bitomule/SwiftyPodsDSL/workflows/Swift/badge.svg)

SwiftyPodsDSL is a domain-specific language (DSL) for writing type-safe CocoaPods podfiles in Swift. It can be used as an independent Swift package to render a plain String containing your podfile declared using Swift

## Declare your CocoaPods dependencies using Swift

```swift
let podfile = Podfile(
    targets: [
        .target(
            name: "Target",
            project: "Project",
            dependencies: [
                .dependency(name: "Dependency1"),
                .dependency(name: "Dependency2",
                            version: "1.2.3"),
                .dependency(name: "Dependency3",
                            .git(url: "repo"),
                            .branch(name: "master"))
            ],
            childTargets: [
                .target(name: "ChildTarget", project: "Project2")
            ]
        )
    ]
)
```

It matches SPM package description syntax because we all love it but it just not there for all of us. This Swift file will generate this podfile String:

```
target 'Target' do
    project 'Project'
    pod 'Dependency1'
    pod 'Dependency2', '1.2.3'
    pod 'Dependency3', :git => 'repo', :branch => 'master'
    target 'ChildTarget' do
        project 'Project2'
        inherit! :search_paths
    end
end
```

## Rendering a podfile

```swift
let podfile = Podfile(
    targets: [
        .target(
            name: "Target",
            project: "Project",
            dependencies: [
                .dependency(name: "Dependency1")
            ]
        )
    ]
)

podfile.render()
```

SwiftyPodsDSL will generate you podfile line by line using spaces to indent your content.

## Installation

SwiftyPods is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/bitomule/SwiftyPodsDSL.git", from: "0.1.0")
    ],
    ...
)
```

Then import SwiftyPodsDSL wherever you’d like to use it:

```swift
import SwiftyPodsDSL
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## What's included
- Podfile
- Target (name, project, dependencies and child targets)
- Dependency (name, version as raw string and git, branch, commit and path properties)
- ChildTarget(adding inherit search paths options to normal target options)
- Tests!

## What's missing (PRs welcome)
- Target properties
- Other Dependency properties
- CocoaPods features not directly related with declaring dependencies (hooks, plugins). This won't be added.

## Contributions and support

Contributions are more than welcome.

Before you start using SwiftyPodsDSL, please take a few minutes to check the implementation so you can identify issues or missing features.

Keep in mind this is a very experimental project, expect breaking changes.

This project does not come with Github Issues enabled. If you find an issue, missing feature or missing documentation please [open a Pull Request](https://github.com/bitomule/SwiftyPodsDSL/pull/new). Your PR could just contain a draft of the changes you plan to do or a test that reproduces the issue so we can start the discussion there.
