import XCTest
import SSGenKit

final class H1Tests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<h1>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</h1>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    func test_printing_containsContent() throws {
        let content = uniqueString()
        let sut = makeSUT(content: content)

        let html = "\(sut)"

        XCTAssertTrue(html.contains(content), "html: \(html) should contain \(content)")
    }

    // MARK: - helpers
    private func makeSUT(content: String = "") -> H1 {
        let element = H1 { content }
        return element
    }

    private func uniqueString() -> String { UUID().uuidString }
}

// MARK: - move to production
struct H1 { 
    private let content: () -> String

    init(content: @escaping () -> String) {
        self.content = content
    }
}

extension H1: CustomStringConvertible {
    var description: String {
        """
<h1>
\(content())
</h1>
"""
    }
}

//let k = H1 {
//    "Thgis is the H1 contents"
//}
// print(k)
//
//"""
//"<h1>
//  Thgis is the H1 contents
//</h1>
//"""
