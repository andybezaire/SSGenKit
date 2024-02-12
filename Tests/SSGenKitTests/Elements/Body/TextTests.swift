import XCTest
import SSGenKit
import InlineSnapshotTesting

final class TextTests: XCTestCase {
    func test_matchesSnapshot() {
        let sut = Text("Hello, World!")

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p>
              Hello, World!
            </p>
            """
        }
    }
}
