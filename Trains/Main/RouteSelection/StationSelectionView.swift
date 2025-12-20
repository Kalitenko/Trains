import SwiftUI

struct StationSelectionView: View {
    
    let stations: [StationItem]
    let onSelect: (StationItem) -> Void
    
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
    let items = [
        StationItem(id: UUID().uuidString, title: "Станция 1"),
        StationItem(id: UUID().uuidString, title: "Станция 2"),
        StationItem(id: UUID().uuidString, title: "Станция 3")
    ]
    NavigationStack {
        StationSelectionView(stations: items) { station in
                print(station)
            }
    }
    .preferredColorScheme(.dark)
}
