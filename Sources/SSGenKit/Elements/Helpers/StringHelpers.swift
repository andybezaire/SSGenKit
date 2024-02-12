extension String {
    enum HTMLTag: String {
        case html, body, p, h1, h2, h3, h4, h5, h6
    }

    init(tag: HTMLTag, content: () -> HTMLElement) {
        self = """
               <\(tag.rawValue)>
                 \(indented: "\(content())")
               </\(tag.rawValue)>
               """
    }
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
