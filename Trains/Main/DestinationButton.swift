import SwiftUI

struct DestinationButton: View {
    
    let destinationTextView: DestinationTextView
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            destinationTextView
        })
    }
    
    init(destination destinationTextView: DestinationTextView, action: @escaping () -> Void) {
        self.destinationTextView = destinationTextView
        self.action = action
    }
}

#Preview {
    DestinationButton(
        destination: DestinationTextView(placeholder: "Куда"),
        action: {
            print("DestinationButton tapped")
    })
    .padding(10)
    .background(Color.yellow)
}
