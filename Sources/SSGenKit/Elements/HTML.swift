struct HTML: HTMLElement {
    typealias HeadContent = () -> HTMLBodyElement

    private let headContent: HeadContent?
    private let bodyContent: () -> HTMLBodyElement

    init(
        headContent: HeadContent? = nil,
        @HTMLBodyElementBuilder bodyContent: @escaping () -> HTMLBodyElement
    ) {
        self.headContent = headContent
        self.bodyContent = bodyContent
    }
}

extension HTML: CustomStringConvertible {
    var description: String {
        let body: String = .init(tag: .body, content: bodyContent)
        return  .init(tag: .html, content: { body })
    }
}

struct Head {
    private let content: () -> HTMLHeadElement

    init(content: @escaping () -> HTMLHeadElement) {
        self.content = content
    }
}

extension Head: HTMLElement {
    var description: String { .init(tag: .head, content: content) }
}
