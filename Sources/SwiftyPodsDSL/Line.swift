import Foundation

struct Line {
    let tabs: Int
    let content: String
}

extension Array where Element == Line {
    func render() -> String {
        self.map { tabs(count: $0.tabs) + $0.content }.joined(separator: "\n")
    }
    
    private func tabs(count: Int) -> String {
        Array<String>(repeating: "\t", count: count).joined()
    }
}
