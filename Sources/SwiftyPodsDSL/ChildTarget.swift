import Foundation

public struct ChildTarget: Encodable  {
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

extension ChildTarget {
    func toString(tabs: Int) -> [Line] {
        var lines = [
            Line(tabs: tabs, content: "target '\(name)' do"),
            Line(tabs: tabs + 1, content: "project '\(project)'"),
        ]
        if inheritSearchPaths {
            lines += [Line(tabs: tabs + 1, content: "\ninherit! :search_paths")]
        }
        lines = lines +
        dependencies.map { $0.toString(tabs: tabs + 1) } +
        childTargets.map { $0.toString(tabs: tabs + 1) }.flatMap { $0 } +
        [Line(tabs: tabs, content: "end")]
        
        return lines
    }
}
