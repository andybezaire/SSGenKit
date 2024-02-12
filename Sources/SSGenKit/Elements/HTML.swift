struct HTML: HTMLElement {
    private let body: () -> Body

    init(body: @escaping () -> Body) {
        self.body = body
    }
}

extension HTML: CustomStringConvertible {
    var description: String { String(tag: .html, content: body) }
}

extension DefaultStringInterpolation {
    mutating func appendInterpolation(indented string: String) {
       let indent = String(stringInterpolation: self).reversed().prefix { " \t".contains($0) }
       if indent.isEmpty {
            appendInterpolation(string)
        } else {
            appendLiteral(string.split(separator: "\n", omittingEmptySubsequences: false).joined(separator: "\n" + indent))
        }
    }
}

extension String {
    enum HTMLTag {
        case html
    }
    
    init(tag: HTMLTag, content: () -> HTMLElement) {
        self = """
               <html>
                 \(indented: "\(content())")
               </html>
               """
    }
}
