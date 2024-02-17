public struct VStack {
    private let content: () -> HTMLBodyElement

    public init(
        @HTMLBodyElementBuilder content: @escaping () -> HTMLBodyElement
    ) {
        self.content = content
    }
}

extension VStack: HTMLBodyElement {
    public var description: String {
        .init(
            tag: .div(style: "align-items:center;display:flex;flex-direction:column;"),
            content: content
        )
    }
}
