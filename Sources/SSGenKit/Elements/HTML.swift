struct HTML: HTMLElement {
    private let body: () -> Body

    init(body: @escaping () -> Body) {
        self.body = body
    }
}

extension HTML: CustomStringConvertible {
    var description: String { .init(tag: .html, content: body) }
}
