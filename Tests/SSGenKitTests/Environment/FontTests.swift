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

    func test_font_matchesSnapshot() throws {
        let (font, tag) = try uniqueFontPair()
        let sut = Text("Hello, World!")
            .font(font)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <\(tag)>
              Hello, World!
            </\(tag)>
            """
        }
    }

    // MARK: - helpers
    private func uniqueFont() -> HTMLBodyFont {
        HTMLBodyFont.allCases.randomElement()!
    }

    private let fontPairTable: [HTMLBodyFont: String] = [
        .mainHeading: "h1",
        .heading: "h2",
        .subheading: "h3",
        .tertiaryHeading: "h4",
        .quaternaryHeading: "h5",
        .quinaryHeading: "h6",
        .body: "p",
    ]

    private func uniqueFontPair() throws -> (font: HTMLBodyFont, tag: String) {
        let font = uniqueFont()
        guard let tag = fontPairTable[font]
        else { throw UnimplementedFontTestError() }

        return (font, tag)
    }

    private struct UnimplementedFontTestError: Error { }
}
