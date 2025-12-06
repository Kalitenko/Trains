import SwiftUI

struct AppBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color(.appBackground).ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View {
        modifier(AppBackground())
    }
}
