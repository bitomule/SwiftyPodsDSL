import Foundation

public struct ChildTarget {
    public let name: String
    public let project: String
    public let inheritSearchPaths: Bool
    public let dependencies: [Dependency]
    public let childTargets: [ChildTarget]
    
    private init(
        name: String,
        project: String,
        inheritSearchPaths: Bool,
        dependencies: [Dependency],
        childTargets: [ChildTarget]
    ) {
        self.name = name
        self.project = project
        self.inheritSearchPaths = inheritSearchPaths
        self.dependencies = dependencies
        self.childTargets = childTargets
    }
    
    public static func target(name: String, project: String, inheritSearchPaths: Bool = true, dependencies: [Dependency] = [], childTargets: [ChildTarget] = []) -> ChildTarget {
        ChildTarget(name: name, project: project, inheritSearchPaths: inheritSearchPaths, dependencies: dependencies, childTargets: childTargets)
    }
}
