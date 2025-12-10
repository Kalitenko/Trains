import SwiftUI

struct AgreementView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer/ru/")!
    
    var body: some View {
        ParentContainer {
            WebView(url: agreementURL)
                .navigationBarBackButtonHidden(true)
                .appBackground()
                .backButtonToolbar(dismiss)
        }
    }
}

#Preview {
    NavigationStack {
        AgreementView()
    }
}
