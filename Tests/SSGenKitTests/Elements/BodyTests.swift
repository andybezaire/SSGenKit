import XCTest
@testable import SSGenKit
import InlineSnapshotTesting

final class BodyTests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<body>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</body>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    func test_printing_containsContent() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        XCTAssertTrue(html.contains(content), "html: \(html) should contain \(content)")
    }

    func test_init_doesNotExecuteContent() throws {
        _ = makeSUT(content: { XCTFail() ; return "" })
    }

    func test_matchesSnapshot() {
        let sut = makeSUT(content: { "This is a body tag." })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <body>
              This is a body tag.
            </body>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> HTMLBodyElement = { "" }) -> HTMLElement {
        let element = Body(content: content)
        return element
    }
}
