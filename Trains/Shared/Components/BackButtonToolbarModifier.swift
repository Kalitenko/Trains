import SwiftUI

struct BackButtonToolbarModifier: ViewModifier {
    let dismiss: DismissAction

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.appTextPrimary)
                    }
                }
            }
    }
}

extension View {
    func backButtonToolbar(_ dismiss: DismissAction) -> some View {
        self.modifier(BackButtonToolbarModifier(dismiss: dismiss))
    }
}

private struct ExampleView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Text("Hello World!")
            .backButtonToolbar(dismiss)
    }
        
}

#Preview {
    NavigationStack {
        ExampleView()
    }
    
}
