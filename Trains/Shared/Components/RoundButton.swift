import SwiftUI

struct RoundButton: View {
    let systemName: String
    let size: CGFloat
    let iconColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(systemName: String, size: CGFloat = 36, iconColor: Color, backgroundColor: Color, action: @escaping () -> Void) {
        self.systemName = systemName
        self.size = size
        self.iconColor = iconColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .foregroundStyle(iconColor)
                .font(.system(size: size * 0.45))
                .frame(width: size, height: size)
                .background(
                    Circle()
                        .fill(backgroundColor)
                )
        }
    }
}

#Preview {
    VStack {
        RoundButton(
            systemName: "arrow.counterclockwise",
            iconColor: .yellow,
            backgroundColor: .green,
            action: {
                print("RoundButton tapped")
            }
        )
        .border(Color.red, width: 2)
        RoundButton(
            systemName: "xmark",
            size: 100,
            iconColor: .appWhite,
            backgroundColor: .appBlack,
            action: {
                print("RoundButton tapped")
            }
        )
        .border(Color.red, width: 2)
        Spacer()
    }
}
