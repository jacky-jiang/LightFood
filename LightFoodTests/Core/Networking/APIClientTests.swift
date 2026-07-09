import XCTest
@testable import LightFood

final class APIClientTests: XCTestCase {
    func testAPIErrorEquatable() {
        XCTAssertEqual(APIError.httpStatus(404), APIError.httpStatus(404))
    }
}
