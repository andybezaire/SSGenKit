public struct H1 {
    private let content: () -> String

    public init(content: @escaping () -> String) {
        self.content = content
    }
}

extension H1: CustomStringConvertible {
    public var description: String {
        """
<h1>
\(content())
</h1>
"""
    }
}
