import SwiftUI

struct TabBarButton: View {
    
    let isSystemName: Bool
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            image
                .foregroundStyle(isSelected ? .appTextPrimary : .appGray)
                .frame(maxWidth: 30, maxHeight: 30)
        }
    }
    
    private var image: some View {
        isSystemName ?
        Image(systemName: imageName)
            .resizable()
            .frame(maxWidth: 30, maxHeight: 30) :
        Image(imageName)
            .renderingMode(.template)
            .resizable()
            .frame(maxWidth: 30, maxHeight: 30)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        TabBarButton(isSystemName: true,
                     imageName: "globe",
                     isSelected: false,
                     action: { print("Выбрана вкладка 3")
        })
        TabBarButton(isSystemName: true,
                     imageName: "globe",
                     isSelected: true,
                     action: { print("Выбрана вкладка 3")
        })
    }
    .preferredColorScheme(.dark)
}
