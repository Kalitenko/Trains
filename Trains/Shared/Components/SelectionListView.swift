import SwiftUI

struct SelectionListView: View {
    
    let title: String
    let items: [String]
    let notFoundText: String
    let searchPlaceholder: String
    let onSelect: (String) -> Void
    
    @State private var searchText = ""
    
    var filteredItems: [String] {
        if searchText.isEmpty { return items }
        return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List(filteredItems, id: \.self) { item in
            Button {
                onSelect(item)
            } label: {
                SelectionListRowView(title: item)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.appBackground)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .overlay {
            if filteredItems.isEmpty {
                Text(notFoundText)
                    .font(.bold24)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: searchPlaceholder)

    }
}

#Preview {
    NavigationStack {
        SelectionListView(
            title: "Выбор",
            items: ["Один", "Два", "Три"],
            notFoundText: "Опция не найдена",
            searchPlaceholder: "Поиск",
            onSelect: { item in
                print("Выбор: \(item)")
            })
    }
}

#Preview("Dark") {
    NavigationStack {
        SelectionListView(
            title: "Выбор",
            items: ["Один", "Два", "Три"],
            notFoundText: "Опция не найдена",
            searchPlaceholder: "Поиск",
            onSelect: { item in
                print("Выбор: \(item)")
            })
    }
    .preferredColorScheme(.dark)
}
