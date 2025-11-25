import SwiftUI

struct DestinationsStackView: View {
    
    let whitherSettlement: String
    let whenceSettlement: String
    let whitherStation: String
    let whenceStation: String
    let whitherAction: () -> Void
    let whenceAction: () -> Void
    
    private let whencePlaceholder = "Откуда"
    private let whitherPlaceholder = "Куда"
    
    var body: some View {
        VStack(spacing: 0) {
            DestinationButton(
                destination: DestinationTextView(
                    placeholder: whencePlaceholder,
                    settlement: whenceSettlement,
                    station: whenceStation
                ),
                action: whenceAction
            )
            
            DestinationButton(
                destination: DestinationTextView(
                    placeholder: whitherPlaceholder,
                    settlement: whitherSettlement,
                    station: whitherStation
                ),
                action: whitherAction
            )
        }
        .background(Color.appWhite)
        .cornerRadius(20)
    }

    init(
        whitherSettlement: String = "",
        whenceSettlement: String = "",
        whitherStation: String = "",
        whenceStation: String = "",
        whitherAction: @escaping () -> Void,
        whenceAction: @escaping () -> Void
    ) {
        self.whitherSettlement = whitherSettlement
        self.whenceSettlement = whenceSettlement
        self.whitherStation = whitherStation
        self.whenceStation = whenceStation
        self.whitherAction = whitherAction
        self.whenceAction = whenceAction
    }
}

#Preview {
    VStack(spacing: 20) {
        DestinationsStackView(
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") }
        )
        .padding(10)
        .background(Color.yellow)
        
        DestinationsStackView(
            whitherSettlement: "Москва",
            whenceSettlement: "Сочи",
            whitherStation: "Курский",
            whenceStation: "Альпика",
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") }
        )
        .padding(10)
        .background(Color.red)
    }
}
