public protocol HTMLElement: CustomStringConvertible { }

// MARK: - head
public protocol HTMLHeadElement: HTMLElement { }
extension String: HTMLHeadElement { }

// MARK: - body
public protocol HTMLBodyElement: HTMLElement { }
extension String: HTMLBodyElement { }
