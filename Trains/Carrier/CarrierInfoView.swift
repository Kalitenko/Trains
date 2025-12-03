import SwiftUI

struct CarrierInfoView: View {
    
    private var imageName: String = "rzd_logo"
    private var carrierName: String = "ОАО «РЖД»"
    private var email: String = "i.lozgkina@yandex.ru"
    private var phone: String = "+7 (904) 329-27-71"
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(imageName)
            name
            contacts
            Spacer()
        }
        .padding(16)
        .appBackground()
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonToolbar(dismiss)
    }
    
    
    private var name: some View {
        Text(carrierName)
            .font(.bold24)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var contacts: some View {
        VStack(alignment: .leading, spacing: 16) {
            ContactView(title: .email, subtitle: email)
            ContactView(title: .phone, subtitle: phone)
        }
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView()
            .border(Color.red)
    }
    .preferredColorScheme(.dark)
}
