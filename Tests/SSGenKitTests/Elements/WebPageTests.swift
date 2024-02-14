import XCTest
import SSGenKit
import InlineSnapshotTesting

final class WebPageTests: XCTestCase {
    func test_init_doesNotExecuteContent() throws {
        _ = makeSUT(content: { XCTFail() ; return "" })
    }

    func test_content_printing_containsDoctype() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        let doctypeIndex = try XCTUnwrap(html.index(of: "<!DOCTYPE html>"), "should contain doctype tag")
        let htmlIndex = try XCTUnwrap(html.index(of: "<html>"))
        XCTAssertTrue(doctypeIndex < htmlIndex, "doctype should be before html open")
    }

    // MARK: - html
    func test_printing_containsHTMLTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<html>"), "should have open tag but was missing")
        let closeIndex = try XCTUnwrap(html.index(of: "</html>"), "should have close tag but was missing")

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    // MARK: - body
    func test_printing_containsBodyTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<body>"), "should have open tag but was missing")
        let closeIndex = try XCTUnwrap(html.index(of: "</body>"), "should have close tag but was missing")
        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
        let htmlCloseIndex = try XCTUnwrap(html.index(of: "</html>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(openIndex > htmlOpenIndex, "tag open should be after html open")
        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html close")
    }

    func test_printing_containsBodyContent() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        let contentIndex = try XCTUnwrap(html.index(of: "\(content)"), "html: \(html) should contain \(content)")
        let bodyOpenIndex = try XCTUnwrap(html.index(of: "<body>"))
        let bodyCloseIndex = try XCTUnwrap(html.index(of: "</body>"))

        XCTAssertTrue(contentIndex > bodyOpenIndex, "content should be after body open")
        XCTAssertTrue(contentIndex < bodyCloseIndex, "content should be before body close")
    }

    // MARK: - snapshots
    func test_content_printing_matchesSnapshot() {
        let sut = WebPage {
            "This is a simple site."
        }

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

    func test_multilineContent_printing_matchesSnapshot() {
        let sut = WebPage {
            "This is a simple site."
            "This is a second line."
        }

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <!DOCTYPE html>
            <html>
              <body>
                This is a simple site.
                This is a second line.
              </body>
            </html>
            """
        }
    }

//    func test_title_printing_containsTitle() throws {
//        let title = uniqueString()
//        let sut = makeSUT(headContent: .init(title: title))
//
//        let html = "\(sut)"
//
//        XCTAssertTrue(html.contains(title), "should contain title")
//    }

    // MARK: - helpers
    private func makeSUT(
        headContent: HeadContent? = nil,
        @HTMLBodyElementBuilder content: @escaping () -> HTMLBodyElement = { Text("empty") }
    ) -> HTMLElement {
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
