import XCTest
import SSGenKit
import InlineSnapshotTesting

final class VStackTests: XCTestCase {
    func test_printing_containsDivTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<div"), "should have open tag but was missing")
        let closeIndex = try XCTUnwrap(html.index(of: "</div>"), "should have close tag but was missing")

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    func test_printing_containsFormatting() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        XCTAssertTrue(
            html.contains(
                #"<div style="display:flex;flex-direction:column;align-items:center;">"#
            )
        )
    }

    func test_printing_containsContent() throws {
        let content = uniqueString()
        let sut = makeSUT(content: content)

        let html = "\(sut)"

        let contentIndex = try XCTUnwrap(html.index(of: "\(content)"), "html: \(html) should contain \(content)")
        let tagOpenIndex = try XCTUnwrap(html.index(of: "<div"))
        let tagCloseIndex = try XCTUnwrap(html.index(of: "</div>"))

        XCTAssertTrue(contentIndex > tagOpenIndex, "content should be after div open")
        XCTAssertTrue(contentIndex < tagCloseIndex, "content should be before div close")
    }

    // MARK: - snapshots
    func test_basic_matchesSnapshot() {
        let sut = VStack {
            Text("Hello, World!")
        }

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <div style="display:flex;flex-direction:column;align-items:center;">
              <p>
                Hello, World!
              </p>
            </div>
            """
        }
    }

    func test_multiline_matchesSnapshot() {
        let sut = VStack {
            Text("Hello, World!")
            Text("Hello, World!")
        }

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <div style="display:flex;flex-direction:column;align-items:center;">
              <p>
                Hello, World!
              </p>
              <p>
                Hello, World!
              </p>
            </div>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: String = "empty") -> HTMLBodyElement {
        let element = VStack { Text(content) }
        return element
    }
}
