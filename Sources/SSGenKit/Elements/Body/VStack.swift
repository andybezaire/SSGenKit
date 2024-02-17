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
