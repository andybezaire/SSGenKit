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

    func test_init_doesNotExecuteContent() throws {
        _ = makeSUT(content: { XCTFail() ; return "" })
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

    // MARK: - helpers
    private func makeSUT(
        headContent: HeadContent? = nil,
        content: @escaping () -> HTMLBodyElement = { Text("") }
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
