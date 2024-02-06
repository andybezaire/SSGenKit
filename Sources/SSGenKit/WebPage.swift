import SwiftUI

public struct WebPage {
    let content: () -> String
    public init(@ViewBuilder content: @escaping () -> String) {
        self.content = content
    }

    public func htmlDocument() -> String {
        return """
<!DOCTYPE html>
<html>
  <body>
  </body>
</html>
"""
    }
}
