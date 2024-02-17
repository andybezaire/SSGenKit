public struct VStack {
    private let content: () -> HTMLBodyElement

    public init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension VStack: HTMLBodyElement {
    public var description: String {
        .init(
            tag: .div(style: "display:flex;flex-direction:column;align-items:center;"),
            content: content
        )
    }
}

//public struct VStack: HTMLBodyElement {
//    @Environment(\.font) private var font
//
//    private let content: () -> HTMLBodyElement
//
//    public init(
//        @HTMLBodyElementBuilder content: @escaping () -> HTMLBodyElement
//    ) {
//        self.content = content
//    }
//
//    public var description: String {
//        .init(tag: .div(), content: content)
//    }
//}
