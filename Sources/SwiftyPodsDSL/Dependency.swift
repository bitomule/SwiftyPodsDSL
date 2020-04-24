import Foundation

public struct Dependency: Encodable  {
    let name: String
    let version: String?
    let properties: [DependencyProperty]
    
    public init(name: String, version: String) {
        self.name = name
        self.version = version
        self.properties = []
    }
    
    public init(name: String) {
        self.name = name
        self.version = nil
        self.properties = []
    }
    
    public init(name: String, _ properties: DependencyProperty...) {
        self.name = name
        self.version = nil
        self.properties = properties
    }
    
    public init(name: String, properties: [DependencyProperty]) {
        self.name = name
        self.version = nil
        self.properties = properties
    }
    
    public init(name: String, version: String, _ properties: DependencyProperty...) {
        self.name = name
        self.version = version
        self.properties = properties
    }
    
    public init(name: String, version: String, properties: [DependencyProperty]) {
        self.name = name
        self.version = version
        self.properties = properties
    }
}

extension Dependency {
    public static func dependency(name: String, version: String) -> Dependency {
        Dependency(name: name, version: version)
    }
    
    public static func dependency(name: String) -> Dependency {
        Dependency(name: name)
    }
    
    public static func dependency(name: String, _ properties: DependencyProperty...) -> Dependency {
        Dependency(name: name, properties: properties)
    }
    
    public static func dependency(name: String, version: String, _ properties: DependencyProperty...) -> Dependency {
        Dependency(name: name, version: version, properties: properties)
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
