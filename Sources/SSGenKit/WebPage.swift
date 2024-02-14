import SwiftUI

public struct WebPage {
    let title: String?
    let content: () -> HTMLBodyElement

    public init(
        title: String? = nil,
        @HTMLBodyElementBuilder content: @escaping () -> HTMLBodyElement
    ) {
        self.title = title
        self.content = content
    }
}

extension WebPage: HTMLElement {
    public var description: String {
        let titleTag = title.map { title in String.init(tag: .title, content: { title }) }
        let headContent = titleTag.map { titleTag in { titleTag } }

        let html = HTML(
            headContent: headContent,
            bodyContent: content
        )

        return """
        <!DOCTYPE html>
        \(html)
        """
    }
}
