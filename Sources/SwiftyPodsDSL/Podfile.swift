import Foundation

public struct Podfile {
    public let targets: [Target]
    
    public init(targets: [Target]) {
        self.targets = targets
    }
}

public extension Podfile {
    func toString() -> String {
        targets.map { $0.toString() }.joined(separator: "\n")
    }
}
