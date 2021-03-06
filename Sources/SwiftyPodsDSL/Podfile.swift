import Foundation

public struct Podfile: Encodable  {
    public let targets: [Target]
    
    public init(targets: [Target]) {
        self.targets = targets
    }
}

public extension Podfile {
    func render() -> String {
        targets.map { $0.render(tabs: 0) }.flatMap { $0 }.render()
    }
}
