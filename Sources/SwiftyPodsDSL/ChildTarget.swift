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

public extension ChildTarget {
    func toString() -> String {
        var target = """
            target '\(name)' do
            project '\(project)'
        """
        if inheritSearchPaths {
            target += "\ninherit! :search_paths\n"
        }
        target += """
            \(dependencies.map { $0.toString() }.joined(separator: "\n"))
            \(childTargets.map { $0.toString() }.joined(separator: "\n"))
        end
        """
        return target
    }
}
