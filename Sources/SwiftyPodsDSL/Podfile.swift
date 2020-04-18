import Foundation

public struct Podfile {
    public let targets: [Target]
    
    public init(targets: [Target]) {
        self.targets = targets
    }
}
