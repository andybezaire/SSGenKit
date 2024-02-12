extension String {
    enum HTMLTag: String {
        case html, body, p
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
