import SwiftUI

public struct WebPage {
    let title: String?
    let content: () -> HTMLBodyElement

    public init(title: String? = nil, content: @escaping () -> HTMLBodyElement) {
        self.title = title
        self.content = content
    }
}

extension WebPage: HTMLElement {
    public var description: String {
        """
        <!DOCTYPE html>
        \(HTML(body: { Body.init(content: content) }))
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
