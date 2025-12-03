import SwiftUI

struct ContactView: View {
    
    let title: ContactType
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.rawValue)
                .font(.regular17)
                .foregroundColor(.appTextPrimary)
            
            Text(subtitle)
                .font(.regular12)
                .foregroundColor(.appBlue)
        }
    }
}

#Preview {
    ContactView(title: .email, subtitle: "i.lozgkina@yandex.ru")
        .border(Color.red)
}
