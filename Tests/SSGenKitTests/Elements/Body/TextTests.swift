import XCTest
import SSGenKit
import InlineSnapshotTesting

final class TextTests: XCTestCase {
    func test_basic_matchesSnapshot() {
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

    func test_formatted_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .font(.mainHeading)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h1>
              Hello, World!
            </h1>
            """
        }
    }
}
