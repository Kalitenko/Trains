import SwiftUI

@main
struct TrainsApp: App {    
    var body: some Scene {
        WindowGroup {
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
            .appBackground()
        }
    }
}
