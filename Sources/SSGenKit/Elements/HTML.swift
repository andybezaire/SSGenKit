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
        let head: String? = headContent.map { .init(tag: .head, content: $0) }

        let bodyStyles: [CSSStyle] = [
            .display(.flex),
            .flexDirection(.column),
            .alignItems(.center),
        ]
        let body: String = .init(tag: .body(styles: bodyStyles), content: bodyContent)

        let html = [head, body]
            .compactMap { $0 }
            .joined(separator: "\n")

        return  .init(tag: .html, content: { html })
    }
}
