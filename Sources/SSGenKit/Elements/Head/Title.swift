public struct Title {
    private let content: () -> String

    public init(content: @escaping () -> String) {
        self.content = content
    }

    public init(_ title: String) {
        self.init(content: { title })
    }
}

extension Title: HTMLHeadElement {
    public var description: String {
        """
        <title>
          \(content())
        </title>
        """
    }
}
