import SwiftUI

struct AgreementView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Agreement View!")
        .navigationBarBackButtonHidden(true)
        .appBackground()
        .backButtonToolbar(dismiss)
    }
}

#Preview {
    NavigationStack {
        AgreementView()
    }
}
