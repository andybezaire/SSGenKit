struct HTML: HTMLElement {
    private let bodyContent: () -> HTMLBodyElement

    init(bodyContent: @escaping () -> HTMLBodyElement) {
        self.bodyContent = bodyContent
    }
}

extension HTML: CustomStringConvertible {
    var description: String {
        let body = Body(content: bodyContent)
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
