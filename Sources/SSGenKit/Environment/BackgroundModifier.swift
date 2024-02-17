extension HTMLBodyElement {
    public func background(_ color: Color) -> HTMLBodyElement {
        let styles = EnvironmentValues.current.styles
        return self
            .environment(\.styles, [.backgroundColor(color)] + styles)
    }
}

extension EnvironmentValues {
    var styles: [CSSStyle] {
        get { self[CSSStylesKey.self] }
        set { self [CSSStylesKey.self] = newValue }
    }
}

private enum CSSStylesKey: EnvironmentKey {
    static let defaultValue: [CSSStyle] = []
}
