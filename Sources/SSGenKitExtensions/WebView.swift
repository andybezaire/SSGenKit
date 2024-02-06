import WebKit
import SwiftUI

#if os(iOS)
@available(iOS 13.0, *)
struct WebView: UIViewRepresentable {
    private let content: () -> String

    init(content: @escaping () -> String) {
        self.content = content
    }

    init(content: String) {
        self.init(content: { content })
    }

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.loadHTMLString(content(), baseURL: nil)
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

@available(iOS 13.0, *)
public extension String {
    func generatePreview() -> some View {
        WebView(content: self)
    }
}
#endif

#if os(macOS)
@available(macOS 10.15, *)
struct WebView: NSViewRepresentable {
    private let content: () -> String

    init(content: @escaping () -> String) {
        self.content = content
    }

    init(content: String) {
        self.init(content: { content })
    }

    func makeNSView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.loadHTMLString(content(), baseURL: nil)
        return view
    }

    func updateNSView(_ uiView: WKWebView, context: Context) { }
}

@available(macOS 10.15, *)
public extension String {
    func generatePreview() -> some View {
        WebView(content: self)
    }
}
#endif
