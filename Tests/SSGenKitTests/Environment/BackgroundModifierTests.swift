import XCTest
import SSGenKit
import InlineSnapshotTesting

final class BackgroundModifierTests: XCTestCase {
    func test_text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .background(CSSColor.black)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p style="background-color:black;">
              Hello, World!
            </p>
            """
        }
    }

    func test_vStack_html_matchesSnapshot() {
        let sut = VStack {
            Text("Hello, World!")
        }
            .background(CSSColor.black)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <div style="align-items:center;background-color:black;display:flex;flex-direction:column;">
              <p>
                Hello, World!
              </p>
            </div>
            """
        }
    }
}
