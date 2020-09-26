import XCTest
@testable import swiftdasm

final class swiftdasmTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swiftdasm().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
