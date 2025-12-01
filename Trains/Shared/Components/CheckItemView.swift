import SwiftUI

enum CheckItemViewStyle {
    case square
    case circle
}

struct CheckItemView: View {
    
    let text: String
    var isSelected: Bool
    let style: CheckItemViewStyle
    let action: () -> Void

    var body: some View {
        HStack {
            Text(text)
                .font(.regular17)
                .foregroundColor(.appTextPrimary)
            Spacer()
            icon
                .font(.system(size: 20, weight: .semibold))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
    
    private var icon: some View {
        switch style {
        case .square:
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .foregroundColor(.appTextPrimary)

        case .circle:
            Image(systemName: isSelected ? "record.circle" : "circle")
                .foregroundColor(.appTextPrimary)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CheckItemView(
            text: "Вариант 1",
            isSelected: false,
            style: .circle) {
                print("Вариант 1")
            }
            .padding(10)
            .background(Color.cyan)
        
        CheckItemView(
            text: "Вариант 2",
            isSelected: true,
            style: .circle) {
                print("Вариант 2")
            }
            .padding(10)
            .background(Color.green)
        
        CheckItemView(
            text: "Вариант 3",
            isSelected: false,
            style: .square) {
                print("Вариант 3")
            }
            .padding(10)
            .background(Color.yellow)
        
        CheckItemView(
            text: "Вариант 4",
            isSelected: true,
            style: .square) {
                print("Вариант 4")
            }
            .padding(10)
            .background(Color.orange)
    }
}
