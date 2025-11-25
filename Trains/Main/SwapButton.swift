import SwiftUI

struct SwapButton: View {
    
    let action: () -> Void
    
    var body: some View {
        RoundButton(
            action: action,
            systemName: "arrow.2.squarepath",
            iconColor: .appBlue,
            backgroundColor: .appWhite)
    }
    
}

#Preview {
    SwapButton(action: {
        print("SwapButton tapped")
    })
    .padding(10)
    .background(Color.yellow)
}
