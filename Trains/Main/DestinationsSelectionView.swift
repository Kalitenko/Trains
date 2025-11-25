import SwiftUI

struct DestinationsSelectionView: View {
    
    let whitherSettlement: String
    let whenceSettlement: String
    let whitherStation: String
    let whenceStation: String
    let whitherAction: () -> Void
    let whenceAction: () -> Void
    let swapAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            DestinationsStackView(
                whitherSettlement: whitherSettlement,
                whenceSettlement: whenceSettlement,
                whitherStation: whitherStation,
                whenceStation: whenceStation,
                whitherAction: whitherAction,
                whenceAction: whenceAction
            )
            SwapButton(action: swapAction)
        }
        .padding(16)
        .background(Color.appBlue)
        .cornerRadius(20)
        
    }
    
    init(
        whitherSettlement: String = "",
        whenceSettlement: String = "",
        whitherStation: String = "",
        whenceStation: String = "",
        whitherAction: @escaping () -> Void,
        whenceAction: @escaping () -> Void,
        swapAction: @escaping () -> Void
    ) {
        self.whitherSettlement = whitherSettlement
        self.whenceSettlement = whenceSettlement
        self.whitherStation = whitherStation
        self.whenceStation = whenceStation
        self.whitherAction = whitherAction
        self.whenceAction = whenceAction
        self.swapAction = swapAction
    }
}

#Preview {
    VStack(spacing: 20) {
        DestinationsSelectionView(
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.cyan)
        
        DestinationsSelectionView(
            whitherSettlement: "Москва",
            whenceSettlement: "Сочи",
            whitherStation: "Курский",
            whenceStation: "Альпика",
            whitherAction: { print("tap куда") },
            whenceAction: { print("tap откуда") },
            swapAction: { print("tap swap") }
        )
        .padding(10)
        .background(Color.secondary)
    }
}
