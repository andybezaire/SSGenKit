import XCTest
import SSGenKit
import InlineSnapshotTesting

final class TextTests: XCTestCase {
    func test_matchesSnapshot() {
        let sut = makeSUT(content: "Hello, World!")

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p>
              Hello, World!
            </p>
            """
        }
    }

    // MARK: - helpers
    private func makeSUT(content: String = "") -> HTMLElement {
        let element = Text(content)
        return element
    }
}
