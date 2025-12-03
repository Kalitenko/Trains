import SwiftUI

struct FilterHeaderView: View {
    let header: String
    
    var body: some View {
        HStack {
            Text(header)
                .font(.bold24)
                .foregroundStyle(.appTextPrimary)
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    FilterHeaderView(header: "Заголовок фильтра")
        .border(Color.green)
}
