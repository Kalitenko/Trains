import SwiftUI

struct ParentContainer<Content: View>: View {
    @Binding var error: ErrorType?
    @ViewBuilder let content: () -> Content

    init(error: Binding<ErrorType?>, @ViewBuilder content: @escaping () -> Content) {
        self._error = error
        self.content = content
    }

    var body: some View {
        content()
            .errorOverlay(error)
    }
}
