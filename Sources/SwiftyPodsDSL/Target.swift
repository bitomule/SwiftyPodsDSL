import Foundation

public extension Podfile {
    public class Target {
        public let name: String
        public let project: String
        public let dependencies: [Dependency]
        public let childTargets: [Target]
        
        fileprivate init(
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
    }
}

public extension Podfile.Target {
    public static func target(name: String, project: String, dependencies: [Dependency]) -> Podfile.Target {
        Podfile.Target(name: name, project: project, dependencies: dependencies)
    }
}
