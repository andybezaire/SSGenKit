public protocol EnvironmentKey {
    associatedtype Value
    static var defaultValue: Value { get }
}

private enum FontKey: EnvironmentKey {
    static let defaultValue: HTMLBodyFont = .body
}

public enum HTMLBodyFont {
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

public struct EnvironmentValues {
    static var current = Self()

    private var storage: [AnyHashable: Any] = [:]

    public subscript<Key: EnvironmentKey>(key: Key.Type) -> Key.Value {
        get {
            guard let environmentValue = self.storage[ObjectIdentifier(key)] as? Key.Value
            else { return Key.defaultValue }
            return environmentValue
        }
        set { 
            self.storage[ObjectIdentifier(key)] = newValue
        }
    }
}

extension EnvironmentValues {
    public var font: HTMLBodyFont {
        get { self[FontKey.self] }
        set { self [FontKey.self] = newValue }
    }
}

@propertyWrapper
public struct Environment<Value>: @unchecked Sendable where Value: Sendable  {
    let keyPath: KeyPath<EnvironmentValues, Value>

    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        EnvironmentValues.current[keyPath: keyPath ]
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

private struct EnvironmentKeyWritingModifier<Element, Value>: HTMLBodyElement where Element: HTMLBodyElement {
    let element: Element
    let keyPath: WritableKeyPath<EnvironmentValues, Value>
    let value: Value

    var description: String {
        let previous = EnvironmentValues.current
        defer { EnvironmentValues.current = previous }
        EnvironmentValues.current[keyPath: keyPath] = value
        return "\(element)"
    }
}
