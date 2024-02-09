import XCTest
import SSGenKit
import SwiftUI

final class WebPageTests: XCTestCase {
    func test_printing_containsDoctype() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        XCTAssertTrue(html.contains("<!DOCTYPE html>"))
    }

    func test_printing_containsHTMLTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<html>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</html>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
    }

    func test_printing_containsDoctypeBeforeHTMLTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let doctypeIndex = try XCTUnwrap(html.index(of: "<!DOCTYPE html>"))
        let htmlIndex = try XCTUnwrap(html.index(of: "<html>"))

        XCTAssertTrue(doctypeIndex < htmlIndex, "doctype should be before html open")
    }

    func test_noContent_printing_containsBodyTag() throws {
        let sut = makeSUT()

        let html = "\(sut)"

        let openIndex = try XCTUnwrap(html.index(of: "<body>"))
        let closeIndex = try XCTUnwrap(html.index(of: "</body>"))
        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
        let htmlCloseIndex = try XCTUnwrap(html.index(of: "</html>"))

        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
        XCTAssertTrue(htmlOpenIndex < openIndex, "html open should be before tag open")
        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html open")
    }

//    func test_stringContent_printing_rendersString() throws {
//        let string = uniqueString()
//        let sut = WebPage {
//            string
//        }
//
//        let html = sut.printing()
//
//        let openIndex = try XCTUnwrap(html.index(of: "<body>"))
//        let closeIndex = try XCTUnwrap(html.index(of: "</body>"))
//        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
//        let htmlCloseIndex = try XCTUnwrap(html.index(of: "</html>"))
//
//        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
//        XCTAssertTrue(htmlOpenIndex < openIndex, "html open should be before tag open")
//        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html open")
//    }

    // MARK: - helpers
    private func makeSUT(@ViewBuilder content: @escaping () -> String = { "" }) -> WebPage {
        let webPage = WebPage(content: content)
        return webPage
    }
}
