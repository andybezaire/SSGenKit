import XCTest
import SSGenKit
import InlineSnapshotTesting

final class FontTests: XCTestCase {
    func test_default_matchesSnapshot() {
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

    func test_mainHeading_matchesSnapshot() {
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

    func test_subheading_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .font(.subheading)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h3>
              Hello, World!
            </h3>
            """
        }
    }
}
