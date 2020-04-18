import Foundation

public struct Target {
    public let name: String
    public let project: String
    public let dependencies: [Dependency]
    public let childTargets: [Target]
    
    private init(
        name: String,
        project: String,
        dependencies: [Dependency],
        childTargets: [Target] = []
    ) {
        self.name = name
        self.project = project
        self.dependencies = dependencies
        self.childTargets = childTargets
    }
    
    public static func target(name: String, project: String, dependencies: [Dependency]) -> Target {
        Target(name: name, project: project, dependencies: dependencies)
    }
}

