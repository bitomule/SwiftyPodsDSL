import Foundation

public struct DependencyProperty: Encodable  {
    let key: String
    let value: String
    
    public static func git(url: String) -> DependencyProperty {
        DependencyProperty(key: "git", value: url)
    }
    
    public static func branch(name: String) -> DependencyProperty {
        DependencyProperty(key: "branch", value: name)
    }
    
    public static func commit(hash: String) -> DependencyProperty {
        DependencyProperty(key: "commit", value: hash)
    }
    
    public static func path(path: String) -> DependencyProperty {
        DependencyProperty(key: "path", value: path)
    }
}

extension DependencyProperty{
    func toString() -> String {
        ":\(key) => '\(value)'"
    }
}
