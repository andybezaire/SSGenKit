import XCTest
import SSGenKit
import InlineSnapshotTesting

final class ForegroundStyleModifierTests: XCTestCase {
    func test_text_html_matchesSnapshot() {
        let sut = Text("Hello, World!")
            .foregroundStyle(.white)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <p style="color:white;">
              Hello, World!
            </p>
            """
        }
    }

    func test_vStack_html_matchesSnapshot() {
        let sut = VStack {
            Text("Hello, World!")
        }
            .foregroundStyle(.white)

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <div style="align-items:center;color:white;display:flex;flex-direction:column;">
              <p>
                Hello, World!
              </p>
            </div>
            """
        }
    }

    // MARK: - helpers
}

//private typealias ColorPairTable = [Color: String]

//private extension ColorPairTable {
//    static func text(for color: Color) throws -> String {
//        guard let text = colorPairTable[color]
//        else { throw UnimplementedColorError(color: color) }
//
//        return text
//    }
//
//    private static let colorPairTable: [Color: String] = [
//        .black: "black",
//        .white: "white",
//    ]
//
//    private struct UnimplementedColorError: Error, CustomDebugStringConvertible {
//        let color: Color
//        var debugDescription: String { "Unimplemented for color: \(color)" }
//    }
//}
