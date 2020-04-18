import Foundation

public struct Target: Encodable  {
    public let name: String
    public let project: String
    public let dependencies: [Dependency]
    public let childTargets: [ChildTarget]
    
    public static func target(name: String, project: String, dependencies: [Dependency] = [], childTargets: [ChildTarget] = []) -> Target {
        Target(name: name, project: project, dependencies: dependencies, childTargets: childTargets)
    }
}

extension Target {
    func toString(tabs: Int) -> [Line] {
        [
            Line(tabs: tabs, content: "target '\(name)' do"),
            Line(tabs: tabs + 1, content: "project '\(project)'")
        ] +
        dependencies.map { $0.toString(tabs: tabs + 1) } +
        childTargets.map { $0.toString(tabs: tabs + 1) }.flatMap { $0 } +
        [Line(tabs: tabs, content: "end")]
    }
}

