struct Body {
    private let content: () -> HTMLBodyElement

    init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension Body: HTMLElement {
    var description: String { .init(tag: .body, content: content) }
}
