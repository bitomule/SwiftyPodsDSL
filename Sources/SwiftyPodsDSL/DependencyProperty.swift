import Foundation

public struct DependencyProperty: Encodable  {
    let key: String
    let value: String
    
    private init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    public static func custom(key: String, value: String) -> DependencyProperty {
        DependencyProperty(key: key, value: value)
    }
    
    public static func git(url: String) -> DependencyProperty {
        DependencyProperty(key: "git", value: "\'\(url)\'")
    }
    
    public static func branch(name: String) -> DependencyProperty {
        DependencyProperty(key: "branch", value: "'\(name)'")
    }
    
    public static func commit(hash: String) -> DependencyProperty {
        DependencyProperty(key: "commit", value: "'\(hash)'")
    }
    
    public static func path(path: String) -> DependencyProperty {
        DependencyProperty(key: "path", value: "'\(path)'")
    }
    
    public static func tag(_ tag: String) -> DependencyProperty {
        DependencyProperty(key: "tag", value: "'\(tag)'")
    }
    
    //:testspecs => ['Tests']
    public static func testsspecs(_ specs: [String]) -> DependencyProperty {
        let specs = specs.map { "'\($0)'" }.joined(separator: ", ")
        return DependencyProperty(key: "testspecs", value: "[\(specs)]" )
    }
}

extension DependencyProperty{
    func render() -> String {
        ":\(key) => \(value)"
    }
}
