import XCTest
import SSGenKit
import InlineSnapshotTesting

final class H1Tests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<h1>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</h1>"))

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

//    func test_matchesSnapshot() {
//        let sut = makeSUT(content: { "This is an h1 tag." })
//
//        let html = "\(sut)"
//
//        assertInlineSnapshot(of: html, as: .lines) {
//            """
//            <h1>
//              This is an h1 tag.
//            </h1>
//            """
//        }
//    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> String = { "" }) -> H1 {
        let element = H1(content: content)
        return element
    }
}
