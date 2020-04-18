import Foundation

public extension Podfile.Target {
    public struct Dependency {
        public let name: String
        public let version: String?
        
        fileprivate init(name: String, version: String?) {
            self.name = name
            self.version = version
        }
    }
}

public extension Podfile.Target.Dependency {
    public func toString() -> String {
        var podLine = "pod \(name)"
        if let version = version {
            podLine += ", \(version)"
        }
        return podLine
    }
}

public extension Podfile.Target.Dependency {
    static func dependency(name: String, version: String) -> Podfile.Target.Dependency {
        Podfile.Target.Dependency(name: name, version: version)
    }
    
    static func dependency(name: String) -> Podfile.Target.Dependency {
        Podfile.Target.Dependency(name: name, version: nil)
    }
}
