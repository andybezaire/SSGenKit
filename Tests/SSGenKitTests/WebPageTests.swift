import XCTest
import SSGenKit

final class WebPageTests: XCTestCase {
    func test_htmlDocument_containsDoctype() throws {
        let sut = WebPage()

        let html = sut.htmlDocument()

        XCTAssertTrue(html.contains("<!DOCTYPE html>"))
    }
}

// MARK: - move to production
public struct WebPage {
    public func htmlDocument() -> String {
        return "<!DOCTYPE html>"
    }
}
