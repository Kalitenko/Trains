import SwiftUI

struct ContactView: View {
    
    let title: ContactType
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.rawValue)
                .font(.regular17)
                .foregroundStyle(.appTextPrimary)
            
            Text(subtitle)
                .font(.regular12)
                .foregroundStyle(.appBlue)
        }
    }
}

#Preview {
    ContactView(title: .email, subtitle: "i.lozgkina@yandex.ru")
        .border(Color.red)
}
