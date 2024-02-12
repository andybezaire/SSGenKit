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
