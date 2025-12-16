import SwiftUI

struct AgreementView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var error: ErrorType? = nil
    private let url: URL?
    
    init() {
        if let validURL = URL(string: "https://yandex.ru/legal/practicum_offer/ru/") {
            self.url = validURL
        } else {
            self.url = nil
            assertionFailure("Invalid agreement URL")
        }
    }
    
    var body: some View {
        ParentContainer(error: $error) {
            if let url = url {
                WebView(url: url)
                    .navigationBarBackButtonHidden(true)
                    .appBackground()
                    .backButtonToolbar(dismiss)
            } else {
                ErrorView(type: .configurationError)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.appBackground)
            }
        }
        .onAppear {
            if url == nil {
                error = .configurationError
            }
        }
    }
}

#Preview {
    NavigationStack {
        AgreementView()
    }
}
