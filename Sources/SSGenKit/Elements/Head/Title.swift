public struct Title: CustomStringConvertible {
    private let content: () -> String

    public init(content: @escaping () -> String) {
        self.content = content
    }

    public init(_ title: String) {
        self.init(content: { title })
    }

    public var description: String {
        """
        <title>
          \(content())
        </title>
        """
    }
}
