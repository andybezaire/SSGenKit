struct HTML {
    typealias HeadContent = () -> HTMLHeadElement

    private let headContent: HeadContent?
    private let bodyContent: () -> HTMLBodyElement

    init(
        headContent: HeadContent?,
        @HTMLBodyElementBuilder bodyContent: @escaping () -> HTMLBodyElement
    ) {
        self.headContent = headContent
        self.bodyContent = bodyContent
    }
}

extension HTML: HTMLElement {
    var description: String {
        let body: String = .init(tag: .body, content: bodyContent)
        let head: String? = headContent.map { head in String.init(tag: .head, content: head) }

        let k: [String] = [head, body].compactMap { $0 }
        return  .init(tag: .html, content: { k.joined(separator: "\n") })
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
