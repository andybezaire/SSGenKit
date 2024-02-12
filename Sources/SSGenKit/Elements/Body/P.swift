public struct P: HTMLBodyElement {
    private let content: () -> HTMLBodyElement

    public init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension P: CustomStringConvertible {
    public var description: String {
        """
        <p>
          \(content())
        </p>
        """
    }
}
