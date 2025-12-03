import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let searchPlaceholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.appGray)
            
            TextField("Поиск", text: $text, prompt:
                        Text(searchPlaceholder).font(.regular17).foregroundStyle(.appGray)
            )
            .foregroundStyle(.appTextPrimary)
            .font(.regular17)
            .textFieldStyle(.plain)
            .foregroundStyle(.appSearchBar)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.appGray)
                }
            }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(Color.appSearchBar)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding([.horizontal, .bottom], 16)
    }
}

#Preview("dark") {
    SearchBar(text: .constant("") , searchPlaceholder: "Поисковая строка")
        .preferredColorScheme(.dark)
}

#Preview {
    SearchBar(text: .constant("") , searchPlaceholder: "Поисковая строка")
        .preferredColorScheme(.light)
}
