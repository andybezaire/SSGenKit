import XCTest
import SSGenKit

final class WebPageTests: XCTestCase {
    func test_htmlDocument_containsDoctype() throws {
        let sut = WebPage()

        let html = sut.htmlDocument()

        XCTAssertTrue(html.contains("<!DOCTYPE html>"))
    }

    func test_htmlDocument_containsHTMLTag() throws {
        let sut = WebPage()

        let html = sut.htmlDocument()

        let openIndex = try XCTUnwrap(html.index(of: "<html>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</html>"))

        XCTAssertTrue(openIndex < closeIndex)
    }

    func test_htmlDocument_containsDoctypeBeforeHTMLTag() throws {
        let sut = WebPage()

        let html = sut.htmlDocument()

        let doctypeIndex = try XCTUnwrap(html.index(of: "<!DOCTYPE html>"))
        let htmlIndex = try XCTUnwrap(html.index(of: "<html>"))

        XCTAssertTrue(doctypeIndex < htmlIndex)
    }

    func test_noContent_htmlDocument_containsEmptyBody() throws {
        let sut = WebPage()

        let html = sut.htmlDocument()

        let openIndex = try XCTUnwrap(html.index(of: "<body>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</body>"))
        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
        let htmlCloseIndex = try XCTUnwrap(html.index(of: "</html>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(htmlOpenIndex < openIndex, "html open should be before tag open")
        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html open")
    }
}

private extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
