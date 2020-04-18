import Foundation

public struct Dependency {
    public let name: String
    public let version: String?
    public let properties: [DependencyProperty]
    
    public static func dependency(name: String, version: String) -> Dependency {
        Dependency(name: name, version: version, properties: [])
    }
    
    public static func dependency(name: String) -> Dependency {
        Dependency(name: name, version: nil, properties: [])
    }
    
    public static func dependency(name: String, _ properties: DependencyProperty...) -> Dependency {
        Dependency(name: name, version: nil, properties: properties)
    }
}

public extension Dependency {
    func toString() -> String {
        var podLine = "pod \(name)"
        if let version = version {
            podLine += ", \(version)"
        }
        return podLine
    }
}
