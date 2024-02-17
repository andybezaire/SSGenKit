extension String {
    enum HTMLTag {
        case html
        case head, title
        case body, p, h1, h2, h3, h4, h5, h6
        case div(styles: [CSSStyle])
    }

    init(tag: HTMLTag, content: () -> HTMLElement) {
        self = """
               <\(tag.styled)>
                 \(indented: "\(content())")
               </\(tag)>
               """
    }

    init(font: HTMLBodyFont, styles: [CSSStyle], content: () -> HTMLElement) {
        guard !styles.isEmpty else { self = .init(font: font, content: content) ; return }

        let style = styles.map(\.description).sorted().joined()

        self = """
               <\(font.htmlTag) style="\(style)">
                 \(indented: "\(content())")
               </\(font.htmlTag)>
               """
    }

    init(font: HTMLBodyFont, content: () -> HTMLElement) {
        self = """
               <\(font.htmlTag)>
                 \(indented: "\(content())")
               </\(font.htmlTag)>
               """
    }
}

extension String.HTMLTag: CustomStringConvertible {
    var description: String {
        switch self {
        case .html:
            "html"
        case .head:
            "head"
        case .title:
            "title"
        case .body:
            "body"
        case .p:
            "p"
        case .h1:
            "h1"
        case .h2:
            "h2"
        case .h3:
            "h3"
        case .h4:
            "h4"
        case .h5:
            "h5"
        case .h6:
            "h6"
        case .div:
            "div"
        }
    }
}

extension String.HTMLTag {
    var styled: String {
        switch self {
        case .html:
            "html"
        case .head:
            "head"
        case .title:
            "title"
        case .body:
            "body"
        case .p:
            "p"
        case .h1:
            "h1"
        case .h2:
            "h2"
        case .h3:
            "h3"
        case .h4:
            "h4"
        case .h5:
            "h5"
        case .h6:
            "h6"
        case let .div(styles):
            #"div style="\#(styles.map(\.description).sorted().joined())""#
        }
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
