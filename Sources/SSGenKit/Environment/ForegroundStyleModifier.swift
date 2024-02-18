extension HTMLBodyElement {
    public func foregroundStyle(_ color: Color) -> HTMLBodyElement {
        let styles = EnvironmentValues.current.styles
        return self
            .environment(\.styles, [.color(color)] + styles)
    }
}
