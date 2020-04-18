import XCTest
@testable import SwiftyPodsDSL

final class SwiftyPodsDSLTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyPodsDSL().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
