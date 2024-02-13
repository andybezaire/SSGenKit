@propertyWrapper
struct Environment<Value>: @unchecked Sendable where Value: Sendable  {
    let keyPath: KeyPath<EnvironmentValues, Value>

    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        EnvironmentValues.current[keyPath: keyPath ]
    }
}

extension HTMLBodyElement {
    func environment<Value>(
        _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
        _ value: Value
    ) -> HTMLBodyElement {
        EnvironmentKeyWritingModifier(element: self, keyPath: keyPath, value: value)
    }
}

struct EnvironmentValues {
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

protocol EnvironmentKey {
    associatedtype Value
    static var defaultValue: Value { get }
}

struct EnvironmentKeyWritingModifier<Element, Value>: HTMLBodyElement where Element: HTMLBodyElement {
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
