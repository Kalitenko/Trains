import SwiftUI

struct SettlementSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let settlements: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        SelectionListView(
            title: "Выбор города",
            items: settlements,
            notFoundText: "Город не найден",
            searchPlaceholder: "Введите запрос",
            onSelect: onSelect
        )
    }
}

#Preview {
    NavigationStack {
        SettlementSelectionView(settlements: [
            "Населенный пункт 1",
            "Населенный пункт 2",
            "Населенный пункт 3"]) { settlement in
                print(settlement)
            }
    }
}
