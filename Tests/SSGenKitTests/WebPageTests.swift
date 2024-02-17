import XCTest
import SSGenKit
import InlineSnapshotTesting

final class WebPageTests: XCTestCase {
    func test_init_doesNotExecuteContent() throws {
        _ = makeSUT(content: { XCTFail() ; return Text("empty") })
    }

    func test_content_printing_containsDoctype() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { Text(content) })

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
        let sut = makeSUT(content: { Text(content) })

        let html = "\(sut)"

        let contentIndex = try XCTUnwrap(html.index(of: "\(content)"), "html: \(html) should contain \(content)")
        let bodyOpenIndex = try XCTUnwrap(html.index(of: "<body>"))
        let bodyCloseIndex = try XCTUnwrap(html.index(of: "</body>"))

        XCTAssertTrue(contentIndex > bodyOpenIndex, "content should be after body open")
        XCTAssertTrue(contentIndex < bodyCloseIndex, "content should be before body close")
    }

    // MARK: - head
    func test_headContent_printing_containsHeadTag() throws {
        let sut = makeSUT(headContent: .init(title: "empty"))

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<head>"), "should have open tag but was missing")
        let closeIndex = try XCTUnwrap(html.index(of: "</head>"), "should have close tag but was missing")
        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
        let bodyOpenIndex = try XCTUnwrap(html.index(of: "<body>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(openIndex > htmlOpenIndex, "tag open should be after html open")
        XCTAssertTrue(closeIndex < bodyOpenIndex, "tag close should be before body open")
    }

    func test_headContent_printing_containsTitleTag() throws {
        let sut = makeSUT(headContent: .init(title: "empty"))

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<title>"), "should have open tag but was missing")
        let closeIndex = try XCTUnwrap(html.index(of: "</title>"), "should have close tag but was missing")
        let headOpenIndex = try XCTUnwrap(html.index(of: "<head>"))
        let headCloseIndex = try XCTUnwrap(html.index(of: "</head>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(openIndex > headOpenIndex, "tag open should be after head open")
        XCTAssertTrue(closeIndex < headCloseIndex, "tag close should be before head close")
    }

    func test_headContent_printing_containsHeadContent() throws {
        let content = uniqueString()
        let sut = makeSUT(headContent: .init(title: content))

        let html = "\(sut)"

        let contentIndex = try XCTUnwrap(html.index(of: "\(content)"), "html: \(html) should contain \(content)")
        let headOpenIndex = try XCTUnwrap(html.index(of: "<head>"))
        let headCloseIndex = try XCTUnwrap(html.index(of: "</head>"))

        XCTAssertTrue(contentIndex > headOpenIndex, "content should be after head open")
        XCTAssertTrue(contentIndex < headCloseIndex, "content should be before head close")
    }

    // MARK: - snapshots
    func test_content_printing_matchesSnapshot() {
        let sut = WebPage {
            Text("This is a simple site.")
        }

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <!DOCTYPE html>
            <html>
              <body>
                <p>
                  This is a simple site.
                </p>
              </body>
            </html>
            """
        }
    }

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
