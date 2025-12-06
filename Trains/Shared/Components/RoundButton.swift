import SwiftUI

struct RoundButton: View {
    let systemName: String
    let size: CGFloat = 36
    let iconColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .foregroundStyle(iconColor)
                .frame(width: size, height: size)
                .background(
                    Circle()
                        .fill(backgroundColor)
                )
        }
    }
}

#Preview {
    RoundButton(
        systemName: "arrow.counterclockwise",
        iconColor: .yellow,
        backgroundColor: .green,
        action: {
            print("RoundButton tapped")
        }
    )
    .border(Color.red, width: 2)
}
