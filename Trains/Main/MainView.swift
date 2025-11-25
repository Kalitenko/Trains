import SwiftUI

struct MainView: View {
    
    var body: some View {
        VStack {
            DestinationsSelectionView(
                whitherAction: { print("tap куда") },
                whenceAction: { print("tap откуда") },
                swapAction: { print("tap swap") }
            )
            .padding(.top, 20)
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
