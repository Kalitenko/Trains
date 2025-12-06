import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    var showDot: Bool = false
    let width: CGFloat?
    let action: () -> Void
    
    init(title: String, showDot: Bool = false, width: CGFloat? = nil, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.showDot = showDot
        self.width = width
    }
    
    var body: some View {
        RoundedRectangleButton(
            title: title,
            textColor: Color.appWhite,
            backgroundColor: Color.appBlue,
            showDot: showDot,
            width: width) {
                action()
            }
            .padding(.horizontal, width == nil ? 16 : 0)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(
            title: "Уточнить время",
            showDot: true,
            action: {
                print("Уточнить время tapped")
            }
        )
        .padding(10)
        .background(Color.yellow)
        
        PrimaryButton(
            title: "Уточнить время",
            showDot: false,
            width: nil,
            action: {
                print("Уточнить время tapped")
            }
        )
        .padding(10)
        .background(Color.yellow)
        
        PrimaryButton(
            title: "Найти",
            width: 150,
            action: {
                print("Найти tapped")
            }
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
