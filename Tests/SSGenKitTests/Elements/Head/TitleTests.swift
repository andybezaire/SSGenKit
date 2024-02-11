import XCTest
import SSGenKit
import InlineSnapshotTesting

final class TitleTests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<title>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</title>"))

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

    func test_init_succeeds() {
        let title = uniqueString()
        let closureInit = Title(content: { title })

        let sut = Title(title)

        XCTAssertEqual("\(sut)", "\(closureInit)")
    }

    func test_matchesSnapshot() {
        let sut = makeSUT(content: { "This is a title tag." })

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <title>
              This is a title tag.
            </title>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> String = { "" }) -> Title {
        let element = Title(content: content)
        return element
    }
}
