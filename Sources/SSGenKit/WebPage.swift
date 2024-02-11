import SwiftUI

public struct WebPage {
    let title: String?
    let content: () -> String

    public init(title: String? = nil, content: @escaping () -> String) {
        self.title = title
        self.content = content
    }
}

extension WebPage: CustomStringConvertible {
    public var description: String {
        """
        <!DOCTYPE html>
        \( HTML { """
                  \(title.map { title in "\(Head { Title(title) })" } ?? "")
                  <body>
                  </body>
        """ })
        </html>
        """
    }
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

private struct HTML: CustomStringConvertible {
    let content: () -> CustomStringConvertible

    var description: String {
        """
        <html>
          \(content())
        </html>
        """
    }
}
