import SwiftUI

struct ParentContainer<Content: View>: View {
    @State private var error: ErrorType? = nil
    let content: () -> Content

    var body: some View {
        content()
            .errorOverlay(error)
    }
}
