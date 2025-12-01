import SwiftUI

struct FilterHeaderView: View {
    var header: String
    
    var body: some View {
        HStack {
            Text(header)
            .font(.bold24)
            .foregroundColor(.appTextPrimary)
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    FilterHeaderView(header: "Заголовок фильтра")
        .border(Color.green)
}
