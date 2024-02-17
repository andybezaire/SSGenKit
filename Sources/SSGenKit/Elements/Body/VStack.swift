public struct VStack {
    @Environment(\.styles) private var styles

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
            tag: .div(styles: [.alignItems(.center), .display(.flex), .flexDirection(.column)]),
            content: content
        )
    }
}
