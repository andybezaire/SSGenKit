extension HTMLBodyElement {
    public func font(_ font: HTMLBodyFont) -> HTMLBodyElement {
        return self
            .environment(\.font, font)
    }
}

extension EnvironmentValues {
    var font: HTMLBodyFont {
        get { self[FontKey.self] }
        set { self [FontKey.self] = newValue }
    }
}

private enum FontKey: EnvironmentKey {
    static let defaultValue: HTMLBodyFont = .body
}
