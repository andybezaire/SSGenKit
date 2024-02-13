public struct Text: HTMLBodyElement {
    @Environment(\.font) private var font

    private let content: String

    public init(_ content: String) {
        self.content = content
    }

    public var description: String {
        .init(tag: font.htmlTag, content: { content })
    }
}
