import SwiftUI

struct StationSelectionView: View {
    
    let stations: [String]
    let onSelect: (String) -> Void
    
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
        StationSelectionView(stations: [
            "Станция 1",
            "Станция 2",
            "Станция 3"]) { station in
                print(station)
            }
    }
    .preferredColorScheme(.dark)
}
