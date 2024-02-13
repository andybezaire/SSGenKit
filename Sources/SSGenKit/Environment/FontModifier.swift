public enum HTMLBodyFont: CaseIterable {
    /// Equivalent to H1
    case mainHeading
    /// Equivalent to H2
    case heading
    /// Equivalent to H3
    case subheading
    /// Equivalent to H4
    case tertiaryHeading
    /// Equivalent to H5
    case quaternaryHeading
    /// Equivalent to H6
    case quinaryHeading
    /// Equivalent to p
    case body
}

extension HTMLBodyElement {
    public func font(_ font: HTMLBodyFont) -> HTMLBodyElement {
        return self
            .environment(\.font, font)
    }
}

extension HTMLBodyElement {
    public func environment<Value>(
        _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
        _ value: Value
    ) -> HTMLBodyElement {
        EnvironmentKeyWritingModifier(element: self, keyPath: keyPath, value: value)
    }
}

extension EnvironmentValues {
    public var font: HTMLBodyFont {
        get { self[FontKey.self] }
        set { self [FontKey.self] = newValue }
    }
}

private enum FontKey: EnvironmentKey {
    static let defaultValue: HTMLBodyFont = .body
}
