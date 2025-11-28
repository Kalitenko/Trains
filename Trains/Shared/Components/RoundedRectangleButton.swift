import SwiftUI

struct RoundedRectangleButton: View {
    
    let title: String
    let action: () -> Void
    let textColor: Color
    let backgroundColor: Color
    var showDot: Bool = false
    let width: CGFloat?

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(textColor)
                
                if showDot {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color.red)
                }
            }
            .padding(.vertical, 20)
            .frame(maxWidth: width ?? .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        RoundedRectangleButton(
            title: "Just button",
            action: {
                print("RoundedRectangleButton tapped")
            },
            textColor: Color.blue,
            backgroundColor: Color.gray,
            showDot: true,
            width: nil
        )
        .padding(10)
        .background(Color.yellow)
        
        RoundedRectangleButton(
            title: "Just button",
            action: {
                print("RoundedRectangleButton tapped")
            },
            textColor: Color.blue,
            backgroundColor: Color.gray,
            showDot: false,
            width: 150
        )
        .padding(10)
        .background(Color.yellow)
    }
}
