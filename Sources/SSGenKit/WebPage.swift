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
        \(HTML(body: { .init(content: content) }))
        """
    }
}
