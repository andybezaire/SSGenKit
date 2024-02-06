import XCTest
import SSGenKit

final class H1Tests: XCTestCase {
    func test_printing_containsTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<h1>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</h1>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    // MARK: - helpers
    private func makeSUT() -> H1 {
        let element = H1()
        return element
    }
}

// MARK: - move to production
struct H1 { }

extension H1: CustomStringConvertible {
    var description: String {
        """
<h1>
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
