public protocol HTMLElement: CustomStringConvertible { }

public protocol HTMLHeadElement: HTMLElement { }

extension String: HTMLHeadElement { }
