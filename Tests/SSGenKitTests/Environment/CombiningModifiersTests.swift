import XCTest
import SSGenKit
import InlineSnapshotTesting

final class CombiningModifiersTests: XCTestCase {
    func test_order1Text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .font(.mainHeading)
            .foregroundStyle(.white)
            .background(CSSColor.black)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h1 style="background-color:black;color:white;">
              Hello, World!
            </h1>
            """
        }
    }

    func test_order2Text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .font(.mainHeading)
            .background(CSSColor.black)
            .foregroundStyle(.white)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h1 style="background-color:black;color:white;">
              Hello, World!
            </h1>
            """
        }
    }

    func test_order3Text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .background(CSSColor.black)
            .foregroundStyle(.white)
            .font(.mainHeading)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h1 style="background-color:black;color:white;">
              Hello, World!
            </h1>
            """
        }
    }

    func test_order4Text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .background(CSSColor.black)
            .font(.mainHeading)
            .foregroundStyle(.white)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <h1 style="background-color:black;color:white;">
              Hello, World!
            </h1>
            """
        }
    }
}
