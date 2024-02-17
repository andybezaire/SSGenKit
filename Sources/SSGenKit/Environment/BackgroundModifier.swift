extension HTMLBodyElement {
    public func background(_ color: Color) -> HTMLBodyElement {
        let currentStyles = EnvironmentValues.current.styles.styles
        let styles: CSSStyles = .init(styles:  ["background-color:\(color)"] + currentStyles)
        return self
            .environment(\.styles, styles)
    }
}

extension EnvironmentValues {
    var styles: CSSStyles {
        get { self[CSSStylesKey.self] }
        set { self [CSSStylesKey.self] = newValue }
    }
}

private enum CSSStylesKey: EnvironmentKey {
    static let defaultValue: CSSStyles = .init(styles: [])
}
