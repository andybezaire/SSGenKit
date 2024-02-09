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
          \(title != nil ? "<head>" : "")
          \(title != nil ? "<title>" : "")
          \(title ?? "")
          \(title != nil ? "</title>" : "")
          \(title != nil ? "</head>" : "")
          <body>
          </body>
        </html>
        """
    }
}
