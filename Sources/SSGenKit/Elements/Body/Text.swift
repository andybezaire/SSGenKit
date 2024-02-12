public struct Text: HTMLBodyElement {
    @Environment(\.font) private var font

    private let content: String

    public init(_ content: String) {
        self.content = content
    }

    public var description: String {
        .init(tag: tag, content: { content })
    }

    private var tag: String.HTMLTag {
        switch font {
        case .mainHeading:
            return .h1
        case .heading:
            return .h2
        case .subheading:
            return .h3
        case .tertiaryHeading:
            return .h4
        case .quaternaryHeading:
            return .h5
        case .quinaryHeading:
            return .h6
        case .body:
            return .p
        }
    }
}
