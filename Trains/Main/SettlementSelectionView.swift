import SwiftUI

struct SettlementSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss

    let onSelect: (String) -> Void
    let settlements: [String] = [
        "Населенный пункт 1",
        "Населенный пункт 2",
        "Населенный пункт 3",
        "Населенный пункт 4",
        "Населенный пункт 5"
    ]

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
        SettlementSelectionView(onSelect: { settlement in
            print(settlement)
        })
    }
}
