enum CSSStyle {
    case alignItems(AlignItemsStyle)
    case backgroundColor(CSSColor)
    case color(CSSColor)
    case display(DisplayStyle)
    case flexDirection(FlexDirectionStyle)

    enum AlignItemsStyle { case center }
    enum DisplayStyle { case flex }
    enum FlexDirectionStyle { case column }
}

extension CSSStyle: CustomStringConvertible {
    var description: String {
        switch self {
        case let .alignItems(style): "align-items:\(style);"
        case let .backgroundColor(color): "background-color:\(color);"
        case let .color(color): "color:\(color);"
        case let .display(style): "display:\(style);"
        case let .flexDirection(style): "flex-direction:\(style);"
        }
    }
}

extension CSSStyle {
    var isBackgroundColor: Bool {
        if case .backgroundColor = self {
            true
        } else {
            false
        }
    }

    var isColor: Bool {
        switch self {
        case .color:
            true
        default:
            false
        }
    }
}
