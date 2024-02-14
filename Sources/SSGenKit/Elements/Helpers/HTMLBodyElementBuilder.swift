@resultBuilder
public struct HTMLBodyElementBuilder {
    public static func buildBlock(_ parts: HTMLBodyElement...) -> HTMLBodyElement {
        HTMLBodyElementStack(items: parts)
    }
}

private struct HTMLBodyElementStack {
    let items: [HTMLBodyElement]
}

extension HTMLBodyElementStack: HTMLBodyElement {
    var description: String {
        items.map(\.description).joined(separator: "\n")
    }
}
