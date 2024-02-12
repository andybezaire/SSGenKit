import XCTest
@testable import SSGenKit
import InlineSnapshotTesting

final class HTMLTests: XCTestCase {
    func test_printing_containsContent() throws {
        let content = uniqueString()
        let sut = makeSUT(body: { .init(content: { content }) })

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<html>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</html>"))
        let bodyOpenIndex = try XCTUnwrap(html.index(of: "<body>"))
        let bodyCloseIndex = try XCTUnwrap(html.index(of: "</body>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(openIndex < bodyOpenIndex, "tag open should be before body open")
        XCTAssertTrue(closeIndex > bodyCloseIndex, "tag close should be after body close")
        XCTAssertTrue(html.contains(content), "html: \(html) should contain \(content)")
    }

    func test_init_doesNotExecuteContent() throws {
        _ = makeSUT(body: { .init(content: { XCTFail() ; return "" }) })
    }

//    func test_matchesSnapshot() {
//        let sut = makeSUT(body: { .init(content: { "This is a body tag." }) })
//
//        let html = "\(sut)"
//
//        assertInlineSnapshot(of: html, as: .lines) {
//            """
//            <html>
//              <body>
//                This is the body.
//              </body>
//            </html>
//            """
//        }
//    }

    // MARK: - helpers
    private func makeSUT(body: @escaping () -> Body) -> HTMLElement {
        let element = HTML(body: body)
        return element
    }
}
