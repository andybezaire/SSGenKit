import XCTest
@testable import SSGenKit
import InlineSnapshotTesting

final class HeadTests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<head>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</head>"))

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
        let sut = makeSUT(content: { "This is a head tag." })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <head>
              This is a head tag.
            </head>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> HTMLHeadElement = { "" }) -> HTMLElement {
        let element = Head(content: content)
        return element
    }
}
