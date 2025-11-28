import SwiftUI

struct StationSelectionView: View {
    
    let onSelect: (String) -> Void
    let stations: [String] = [
        "Станция 1",
        "Станция 2",
        "Станция 3",
        "Станция 4",
        "Станция 5"
    ]
    
    var body: some View {
        SelectionListView(
            title: "Выбор станции",
            items: stations,
            notFoundText: "Станция не найдена",
            searchPlaceholder: "Введите запрос",
            onSelect: onSelect)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(onSelect: { station in
            print(station)
        })
    }
    .preferredColorScheme(.dark)
}
