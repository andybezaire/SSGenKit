import XCTest
import SSGenKit

final class ExampleUseTests: XCTestCase {
//    func test_() {
//        WebPage(title: "Homepage") {
//            VStack {
//                H1("Jere Teittinen")
//                    .font(.largeTitle)
//                P("""
//                    Hello. I am an experienced developer who strives to find
//                    simple solutions to complicated problems
//""")
//            }
//        }
//    }

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
}
