public struct VStack {
    @Environment(\.styles) private var styles

    private let content: () -> HTMLBodyElement

    public init(
        @HTMLBodyElementBuilder content: @escaping () -> HTMLBodyElement
    ) {
        self.content = content
    }
}

extension VStack: HTMLBodyElement {
    public var description: String {
        let background = styles.filter(\.isBackgroundColor).first

        let vstackStyles: [CSSStyle] = [
            .alignItems(.center),
            .display(.flex),
            .flexDirection(.column)
        ]

        let newStyles = (vstackStyles + [background]).compactMap { $0 }

        let currentStyles = EnvironmentValues.current.styles
        defer { EnvironmentValues.current.styles = currentStyles }
        EnvironmentValues.current.styles = currentStyles.filter { !$0.isBackgroundColor }

        return .init(tag: .div(styles: newStyles), content: content)
    }
}
