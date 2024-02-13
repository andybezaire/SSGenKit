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

    func test_matchesSnapshot() {
        let sut = makeSUT(body: { .init(content: { "This is the body." }) })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <html>
              <body>
                This is the body.
              </body>
            </html>
            """
        }
    }

    //    func test_headContent_printing_containsHeadTag() throws {
    //        let sut = makeSUT(headContent: .init(title: uniqueString()))
    //
    //        let html = "\(sut)"
    //
    //        let openIndex = try XCTUnwrap(html.index(of: "<head>"))
    //        let closeIndex = try XCTUnwrap(html.index(of: "</head>"))
    //        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
    //        let bodyOpenIndex = try XCTUnwrap(html.index(of: "<body>"))
    //
    //        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    //        XCTAssertTrue(htmlOpenIndex < openIndex, "tag open should be after html open")
    //        XCTAssertTrue(closeIndex < bodyOpenIndex, "tag close should be before body open")
    //    }

    //    func test_title_printing_containsTitle() throws {
    //        let title = uniqueString()
    //        let sut = makeSUT(headContent: .init(title: title))
    //
    //        let html = "\(sut)"
    //
    //        let openIndex = try XCTUnwrap(html.index(of: "<title>"))
    //        let closeIndex = try XCTUnwrap(html.index(of: "</title>"))
    //        let headOpenIndex = try XCTUnwrap(html.index(of: "<head>"))
    //        let headCloseIndex = try XCTUnwrap(html.index(of: "</head>"))
    //        let titleIndex = try XCTUnwrap(html.index(of: title))
    //
    //        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    //        XCTAssertTrue(headOpenIndex < openIndex, "tag open should be after head open")
    //        XCTAssertTrue(closeIndex < headCloseIndex, "tag close should be before head close")
    //        XCTAssertTrue(titleIndex > openIndex, "content should be after tag open")
    //        XCTAssertTrue(titleIndex < closeIndex, "content should be before tag close")
    //
    //    }

    // MARK: - helpers
    private func makeSUT(body: @escaping () -> Body) -> HTMLElement {
        let element = HTML(body: body)
        return element
    }
}
