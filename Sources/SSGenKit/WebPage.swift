import SwiftUI

public struct WebPage {
    let title: String?
    let content: () -> HTMLBodyElement

    public init(title: String? = nil, content: @escaping () -> HTMLBodyElement) {
        self.title = title
        self.content = content
    }
}

extension WebPage: CustomStringConvertible {
    public var description: String { return "<!DOCTYPE html>" }
//        """
//        <!DOCTYPE html>
//        \( HTML { """
//                  \(title.map { title in "\(Head { Title(title) })" } ?? "")
//                  <body>
//                  </body>
//        """ })
//        </html>
//        """
//    }
}

private struct Head: CustomStringConvertible {
    let content: () -> CustomStringConvertible

    var description: String {
        """
        <head>
          \(content())
        </head>
        """
    }
}
