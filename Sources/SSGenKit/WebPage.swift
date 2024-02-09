import SwiftUI

public struct WebPage {
    let content: () -> String
    public init(@ViewBuilder content: @escaping () -> String) {
        self.content = content
    }
}

extension WebPage: CustomStringConvertible {
    public var description: String {
        """
        <!DOCTYPE html>
        <html>
          <body>
          </body>
        </html>
        """
    }
}
