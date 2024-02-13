import XCTest
import SSGenKit
import InlineSnapshotTesting

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

    func test_helloWorld_matchesSnapshot() {
        let sut = WebPage {
            Text("Hello, World!")
        }

        let html = "\(sut)"

        assertInlineSnapshot(of: html, as: .lines) {
            """
            <!DOCTYPE html>
            <html>
              <body>
                <p>
                  Hello, World!
                </p>
              </body>
            </html>
            """
        }
    }
}
