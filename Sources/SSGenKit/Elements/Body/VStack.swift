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
        let color = styles.filter(\.isColor).first

        let vstackStyles: [CSSStyle] = [
            .alignItems(.center),
            .display(.flex),
            .flexDirection(.column)
        ]

        let newStyles = (vstackStyles + [background, color]).compactMap { $0 }

        let currentStyles = EnvironmentValues.current.styles
        defer { EnvironmentValues.current.styles = currentStyles }
        EnvironmentValues.current.styles = currentStyles.filter { !$0.isBackgroundColor && !$0.isColor }

        return .init(tag: .div(styles: newStyles), content: content)
    }
}
