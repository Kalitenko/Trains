import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let searchPlaceholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appGray)
            
            TextField("Поиск", text: $text, prompt:
                        Text(searchPlaceholder).font(.regular17).foregroundColor(.appGray)
            )
            .foregroundColor(.appTextPrimary)
            .font(.regular17)
                .textFieldStyle(.plain)
                .foregroundStyle(.appSearchBar)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.appGray)
                }
            }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(Color.appSearchBar)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
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
