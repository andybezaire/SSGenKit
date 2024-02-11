// MARK: - move to production
public struct P {
    private let content: () -> String

    public init(content: @escaping () -> String) {
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
