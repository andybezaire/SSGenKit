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
        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html close")
    }

    func test_emptyHeadContent_printing_containsNoHeadTag() throws {
        let sut = makeSUT(headContent: nil)

        let html = "\(sut)"

        XCTAssertNil(html.index(of: "<head>"))
        XCTAssertNil(html.index(of: "</head>"))
    }

//    func test_headContent_printing_containsHeadTag() throws {
//        let sut = makeSUT(headContent: [.title(uniqueString())])
//
//        let html = "\(sut)"
//
//        let openIndex = try XCTUnwrap(html.index(of: "<head>"))
//        let closeIndex = try XCTUnwrap(html.index(of: "</head>"))
//        let htmlOpenIndex = try XCTUnwrap(html.index(of: "<html>"))
//        let htmlCloseIndex = try XCTUnwrap(html.index(of: "</html>"))
//
//        XCTAssertTrue(openIndex < closeIndex, "tag open should be before close")
//        XCTAssertTrue(htmlOpenIndex < openIndex, "html open should be before tag open")
//        XCTAssertTrue(closeIndex < htmlCloseIndex, "tag close should be before html close")
//    }

    // MARK: - helpers
    private func makeSUT(
        headContent: HeadContent? = nil,
        @ViewBuilder content: @escaping () -> String = { "" }
    ) -> WebPage {
        let sut = if let title = headContent?.title {
            WebPage(title: title, content: content)
        } else {
            WebPage(content: content)
        }
        
        return sut
    }

    private struct HeadContent {
        let title: String?
    }
}
