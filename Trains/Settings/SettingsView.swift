import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea(edges: .all)
            Text("Settings View")
        }
    }
}

#Preview {
    SettingsView()
}
