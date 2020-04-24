import Foundation

public struct Target: Encodable  {
    let name: String
    let project: String
    let dependencies: [Dependency]
    let childTargets: [ChildTarget]
    
    public init(name: String, project: String, dependencies: [Dependency] = [], childTargets: [ChildTarget] = []) {
        self.name = name
        self.project = project
        self.dependencies = dependencies
        self.childTargets = childTargets
    }
    
    public init(name: String, project: String, dependencies: [[Dependency]], childTargets: [ChildTarget] = []) {
        self.name = name
        self.project = project
        self.dependencies = dependencies.flatMap { $0 }
        self.childTargets = childTargets
    }
    
    public static func target(name: String, project: String, dependencies: [Dependency] = [], childTargets: [ChildTarget] = []) -> Target {
        Target(name: name, project: project, dependencies: dependencies, childTargets: childTargets)
    }
    
    public static func target(name: String, project: String, dependencies: [[Dependency]], childTargets: [ChildTarget] = []) -> Target {
        Target(name: name, project: project, dependencies: dependencies, childTargets: childTargets)
    }
}

extension Target {
    func render(tabs: Int) -> [Line] {
        [
            Line(tabs: tabs, content: "target '\(name)' do"),
            Line(tabs: tabs + 1, content: "project '\(project)'")
        ] +
        dependencies.map { $0.render(tabs: tabs + 1) } +
        childTargets.map { $0.render(tabs: tabs + 1) }.flatMap { $0 } +
        [Line(tabs: tabs, content: "end")]
    }
}

