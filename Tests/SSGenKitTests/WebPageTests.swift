import XCTest
import SSGenKit
import InlineSnapshotTesting

final class WebPageTests: XCTestCase {
    func test_printing_succeeds() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        let doctypeIndex = try XCTUnwrap(html.index(of: "<!DOCTYPE html>"))
        let htmlIndex = try XCTUnwrap(html.index(of: "<html>"))
        XCTAssertTrue(html.contains("<!DOCTYPE html>"), "should contain doctype tag")
        XCTAssertTrue(doctypeIndex < htmlIndex, "doctype should be before html open")
        XCTAssertTrue(html.contains(content), "should contain content")
    }

    func test_printing_matchesSnapshot() {
        let content = "This is a simple site."
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <!DOCTYPE html>
            <html>
              <body>
                This is a simple site.
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
    private func makeSUT(
        headContent: HeadContent? = nil,
        content: @escaping () -> HTMLBodyElement = { Text("") }
    ) -> WebPage {
        let sut = if let title = headContent?.title {
            WebPage(title: title, content: content)
        } else {
            WebPage(content: content)
        }

        return sut
    }

    private struct HeadContent {
        let title: String?
    }
}
