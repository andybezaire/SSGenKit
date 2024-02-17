public struct Text: HTMLBodyElement {
    @Environment(\.font) private var font
    @Environment(\.styles) private var styles

    private let content: String

    public init(_ content: String) {
        self.content = content
    }

    public var description: String {
        .init(font: font, styles: styles, content: { content })
    }
}
