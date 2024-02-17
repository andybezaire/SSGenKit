import XCTest
@testable import SSGenKit

final class CSSStyleTests: XCTestCase {
    func test_allStyles_print_succeeds() throws {
        XCTAssertEqual("\(CSSStyle.alignItems(.center))","align-items:center;")
        XCTAssertEqual("\(CSSStyle.backgroundColor(.black))","background-color:black;")
        XCTAssertEqual("\(CSSStyle.backgroundColor(.white))","background-color:white;")
        XCTAssertEqual("\(CSSStyle.display(.flex))","display:flex;")
        XCTAssertEqual("\(CSSStyle.flexDirection(.column))","flex-direction:column;")
    }
}
