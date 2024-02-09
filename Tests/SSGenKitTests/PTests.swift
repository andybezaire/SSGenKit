import XCTest
import SSGenKit

final class PTests: XCTestCase {
    func test_noContent_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<p>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</p>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    func test_printing_containsContent() throws {
        let content = uniqueString()
        let sut = makeSUT(content: { content })

        let html = "\(sut)"

        XCTAssertTrue(html.contains(content), "html: \(html) should contain \(content)")
    }

//    func test_init_doesNotExecuteContent() throws {
//        let content = uniqueString()
//        let sut = makeSUT(content: content)
//
//        let html = "\(sut)"
//
//        XCTAssertTrue(html.contains(content), "html: \(html) should contain \(content)")
//    }

    // MARK: - helpers
    private func makeSUT(content: @escaping () -> String = { "" }) -> P {
        let element = P(content: content)
        return element
    }
}

// MARK: - move to production
public struct P {
    private let content: () -> String

    public init(content: @escaping () -> String) {
        self.content = content
    }
}

extension P: CustomStringConvertible {
    public var description: String {
        """
<p>
\(content())
</p>
"""
    }
}
