struct P: HTMLBodyElement {
    private let content: () -> HTMLBodyElement

    init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension P: CustomStringConvertible {
    var description: String { .init(tag: .p, content: content) }
}
