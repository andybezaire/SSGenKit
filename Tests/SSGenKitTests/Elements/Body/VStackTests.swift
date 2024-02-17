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

//    func test_printing_containsContent() throws {
//        let content = uniqueString()
//        let sut = makeSUT(content: content)
//
//        let html = "\(sut)"
//
//        let contentIndex = try XCTUnwrap(html.index(of: "\(content)"), "html: \(html) should contain \(content)")
//        let tagOpenIndex = try XCTUnwrap(html.index(of: "<p>"))
//        let tagCloseIndex = try XCTUnwrap(html.index(of: "</p>"))
//
//        XCTAssertTrue(contentIndex > tagOpenIndex, "content should be after body open")
//        XCTAssertTrue(contentIndex < tagCloseIndex, "content should be before body close")
//    }

    // MARK: - snapshots
//    func test_basic_matchesSnapshot() {
//        let sut = Text("Hello, World!")
//
//        let html = "\(sut)"
//
//        assertInlineSnapshot(of: html, as: .lines) {
//            """
//            <p>
//              Hello, World!
//            </p>
//            """
//        }
//    }

//    func test_formatted_matchesSnapshot() {
//        let sut = Text("Hello, World!")
//            .font(.mainHeading)
//
//        let html = "\(sut)"
//
//        assertInlineSnapshot(of: html, as: .lines) {
//            """
//            <h1>
//              Hello, World!
//            </h1>
//            """
//        }
//    }

    // MARK: - helpers
    private func makeSUT(content: HTMLBodyElement = Text("empty")) -> HTMLBodyElement {
        let element = VStack { content }
        return element
    }
}

struct VStack {
    let content: () -> HTMLBodyElement
}

extension VStack: HTMLBodyElement {
    var description: String {
        "<div></div>"
    }
}
