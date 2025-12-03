import SwiftUI

struct RoundButton: View {
    let action: () -> Void
    let systemName: String
    let size: CGFloat = 36
    let iconColor: Color
    let backgroundColor: Color
    
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
        action: {
            print("RoundButton tapped")
        },
        systemName: "arrow.counterclockwise",
        iconColor: .yellow,
        backgroundColor: .green
    )
    .border(Color.red, width: 2)
}
