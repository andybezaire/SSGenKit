import SwiftUI

public struct WebPage {
    let title: String?
    let content: () -> String

    public init(title: String? = nil, @ViewBuilder content: @escaping () -> String) {
        self.title = title
        self.content = content
    }
}

extension WebPage: CustomStringConvertible {
    public var description: String {
        """
        <!DOCTYPE html>
        <html>
          \(title.map { title in "\(Head { Title(title) })" } ?? "")
          <body>
          </body>
        </html>
        """
    }
}

private struct Title: CustomStringConvertible {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var description: String {
        "<title>\(title)</title>"
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
