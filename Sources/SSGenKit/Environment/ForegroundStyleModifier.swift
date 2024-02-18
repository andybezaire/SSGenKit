extension HTMLBodyElement {
    public func foregroundStyle(_ color: CSSColor) -> HTMLBodyElement {
        return self
            .environment(\.styles, appending: .color(color))
    }
}
