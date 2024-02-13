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

    init(font: HTMLBodyFont, content: () -> HTMLElement) {
        self = """
               <\(font.htmlTag.rawValue)>
                 \(indented: "\(content())")
               </\(font.htmlTag.rawValue)>
               """
    }
}

extension HTMLBodyFont {
    var htmlTag: String.HTMLTag {
        switch self {
        case .mainHeading:
            return .h1
        case .heading:
            return .h2
        case .subheading:
            return .h3
        case .tertiaryHeading:
            return .h4
        case .quaternaryHeading:
            return .h5
        case .quinaryHeading:
            return .h6
        case .body:
            return .p
        }
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
