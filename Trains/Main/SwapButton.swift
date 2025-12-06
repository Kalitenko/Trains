import SwiftUI

struct SwapButton: View {
    
    let action: () -> Void
    
    var body: some View {
        RoundButton(
            systemName: "arrow.2.squarepath",
            iconColor: .appBlue,
            backgroundColor: .appWhite) {
                action()
            }
    }
}

#Preview {
    SwapButton {
        print("SwapButton tapped")
    }
    .padding(10)
    .background(Color.yellow)
}
