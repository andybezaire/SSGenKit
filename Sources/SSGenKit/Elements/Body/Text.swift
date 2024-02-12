public struct Text: HTMLBodyElement {
    private let content: String

    public init(_ content: String) {
        self.content = content
    }

    public var description: String {
        "\(P(content: { content }))"
    }
}
