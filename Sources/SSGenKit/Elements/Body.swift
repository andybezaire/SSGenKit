struct Body: HTMLElement {
    private let content: () -> HTMLBodyElement

    init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension Body: CustomStringConvertible {
    var description: String { .init(tag: .body, content: content) }
}
