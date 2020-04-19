import Foundation

public struct Dependency: Encodable  {
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

extension Dependency {
    func render(tabs: Int) -> Line {
        var podLine = "pod '\(name)'"
        if let version = version {
            podLine += ", '\(version)'"
        }
        if properties.count > 0 {
            podLine += ", "
        }
        podLine += properties.map { $0.render() }.joined(separator: ", ")
        return Line(tabs: tabs, content: podLine)
    }
}
