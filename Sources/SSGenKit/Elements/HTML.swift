struct HTML: HTMLElement {
    private let body: () -> Body

    init(body: @escaping () -> Body) {
        self.body = body
    }
}

extension HTML: CustomStringConvertible {
    var description: String { .init(tag: .html, content: body) }
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
