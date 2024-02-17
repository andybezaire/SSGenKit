import XCTest
import SSGenKit
import InlineSnapshotTesting

final class BackgroundModifierTests: XCTestCase {
    func test_black_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .background(Color.black)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p style="background-color:black">
              Hello, World!
            </p>
            """
        }
    }

//    func test_randomFont_html_matchesSnapshot() throws {
//        try HTMLBodyFont.allCases.forEach { font in
//            let tag = try FontPairTable.tag(for: font)
//            let sut = Text("Hello, World!")
//                .font(font)
//
//            let html = "\(sut)"
//
//            assertInlineSnapshot(of: html, as: .lines, message: "Snapshot did not match for font: \(font)") {
//                """
//                <\(tag)>
//                  Hello, World!
//                </\(tag)>
//                """
//            }
//        }
//    }

    // MARK: - helpers
//    private func uniqueFont() -> HTMLBodyFont {
//        HTMLBodyFont.allCases.randomElement()!
//    }
}

//typealias FontPairTable = [HTMLBodyFont: String]

//private extension FontPairTable {
//    static func tag(for font: HTMLBodyFont) throws -> String {
//        guard let tag = fontPairTable[font]
//        else { throw UnimplementedFontError(font) }
//
//        return tag
//    }
//
//    private static let fontPairTable: [HTMLBodyFont: String] = [
//        .mainHeading: "h1",
//        .heading: "h2",
//        .subheading: "h3",
//        .tertiaryHeading: "h4",
//        .quaternaryHeading: "h5",
//        .quinaryHeading: "h6",
//        .body: "p",
//    ]
//
//    private struct UnimplementedFontError: Error, CustomDebugStringConvertible {
//        let font: HTMLBodyFont
//
//        init(_ font: HTMLBodyFont) {
//            self.font = font
//        }
//
//        var debugDescription: String {
//            "Unimplemented for font: \(font)"
//        }
//    }
//}
