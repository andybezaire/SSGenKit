extension HTMLBodyElement {
    public func background(_ color: CSSColor) -> HTMLBodyElement {
        return self
            .environment(\.styles, appending: .backgroundColor(color))
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
