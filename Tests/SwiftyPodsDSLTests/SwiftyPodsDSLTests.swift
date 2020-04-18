import XCTest
@testable import SwiftyPodsDSL

final class SwiftyPodsDSLTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(podfile.toString(), "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
