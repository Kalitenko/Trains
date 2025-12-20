import SwiftUI

struct SettlementSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let settlements: [SettlementItem]
    let onSelect: (SettlementItem) -> Void
    
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
    let items = [
        SettlementItem(id: UUID().uuidString, title: "Населенный пункт 1", stations: []),
        SettlementItem(id: UUID().uuidString, title: "Населенный пункт 2", stations: []),
        SettlementItem(id: UUID().uuidString, title: "Населенный пункт 3", stations: [])
    ]
    NavigationStack {
        SettlementSelectionView(settlements: items) { settlement in
            print(settlement)
        }
    }
}
