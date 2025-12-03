import SwiftUI

struct TabBarButton: View {
    
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.system(size: 26, weight: .regular))
                .foregroundColor(isSelected ? .appTextPrimary : .appGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        TabBarButton(imageName: "globe", isSelected: false, action: { print("Выбрана вкладка 3") })
        TabBarButton(imageName: "globe", isSelected: true, action: { print("Выбрана вкладка 3") })
    }.preferredColorScheme(.dark)
}
