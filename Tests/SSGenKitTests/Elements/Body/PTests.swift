import XCTest
import SSGenKit
import InlineSnapshotTesting

final class PTests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<p>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</p>"))

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
        let sut = makeSUT(content: { "This is a p tag." })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p>
              This is a p tag.
            </p>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> String = { "" }) -> HTMLBodyElement {
        let element = P(content: content)
        return element
    }
}
