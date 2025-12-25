import SwiftUI

struct SelectionListView<Item: SelectionItem>: View {
    
    let title: String
    let items: [Item]
    let notFoundText: String
    let searchPlaceholder: String
    @Binding var error: ErrorType?
    @Binding var isLoading: Bool
    let onSelect: (Item) -> Void
    
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    var filteredItems: [Item] {
        searchText.isEmpty ? items : items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ParentContainer(error: $error) {
            ZStack {
                VStack(spacing: 0) {
                    SearchBar(text: $searchText, searchPlaceholder: searchPlaceholder)
                    List(filteredItems, id: \.self) { item in
                        Button {
                            onSelect(item)
                        } label: {
                            SelectionListRowView(title: item.title)
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
                    .opacity(isLoading ? 0 : 1)
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .backButtonToolbar(dismiss)
                }
                .appBackground()
                
                CircularProgressView()
                    .opacity(isLoading ? 1 : 0)
            }
        }
    }
}

private struct SelectionItemExample: SelectionItem {
    var id: UUID = UUID()
    var title: String
}

#Preview {
    let items = [SelectionItemExample(title: "Один"), SelectionItemExample(title: "Два"), SelectionItemExample(title: "Три")]
    NavigationStack {
        SelectionListView(
            title: "Выбор",
            items: items,
            notFoundText: "Опция не найдена",
            searchPlaceholder: "Поиск",
            error: .constant(nil),
            isLoading: .constant(true),
            onSelect: { item in
                print("Выбор: \(item)")
            })
    }
}
