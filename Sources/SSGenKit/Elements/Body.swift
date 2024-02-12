struct Body: HTMLBodyElement {
    private let content: () -> HTMLBodyElement

    init(content: @escaping () -> HTMLBodyElement) {
        self.content = content
    }
}

extension Body: CustomStringConvertible {
    var description: String {
        """
        <body>
          \(content())
        </body>
        """
    }
}
