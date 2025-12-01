import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    let action: () -> Void
    var showDot: Bool = false
    let width: CGFloat?
    
    init(title: String, action: @escaping () -> Void, showDot: Bool = false, width: CGFloat? = nil) {
        self.title = title
        self.action = action
        self.showDot = showDot
        self.width = width
    }
    
    var body: some View {
        RoundedRectangleButton(
            title: title,
            action: action,
            textColor: Color.appWhite,
            backgroundColor: Color.appBlue,
            showDot: showDot,
            width: width)
        .padding(.horizontal, width == nil ? 16 : 0)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(
            title: "Уточнить время",
            action: {
                print("Уточнить время tapped")
            },
            showDot: true,
            width: nil
        )
        .padding(10)
        .background(Color.yellow)
        
        PrimaryButton(
            title: "Уточнить время",
            action: {
                print("Уточнить время tapped")
            },
            showDot: false,
            width: nil
        )
        .padding(10)
        .background(Color.yellow)
        
        PrimaryButton(
            title: "Найти",
            action: {
                print("Найти tapped")
            },
            width: 150
        )
        .padding(10)
        .background(Color.gray)
        
        PrimaryButton(
            title: "Применить",
            action: {
                print("Применить tapped")
            }
        )
        .padding(10)
        .background(Color.red)
    }
}
