import SwiftUI

struct CarrierSelectionRowView: View {
    
    let carrier: Carrier
    
    var body: some View {
        VStack(spacing: 0) {
            topRowPart
            lowRowPart
        }
        .background(.appLightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        
    }
    
    private var topRowPart: some View {
        HStack(spacing: 8) {
            carrierPic
            textPart
        }
        .padding([.top, .leading], 14)
        .padding(.bottom, 4)
        .padding(.trailing, 7)
    }
    
    private var carrierPic: some View {
        Image(carrier.imageName)
            .resizable()
            .frame(width: 38, height: 38)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var textPart: some View {
        VStack(alignment: .leading, spacing: 4) {
            carrierAndDate
            
            if let connectingStation = carrier.connectingStation {
                Text(connectingStation)
                    .font(.regular12)
                    .foregroundStyle(.appRed)
            }
        }
    }
    
    private var carrierAndDate: some View {
        HStack(alignment: .top) {
            Text(carrier.carrierName)
                .font(.regular17)
                .foregroundStyle(.appBlack)
            
            Spacer()
            
            VStack() {
                Text(carrier.date)
                    .font(.regular12)
                    .padding(.top, 1)
                    .foregroundStyle(.appBlack)
            }
            
        }
    }
    
    private var lowRowPart: some View {
        HStack(spacing: 4) {
            Text(carrier.startTime)
                .font(.regular17)
                .foregroundStyle(.appBlack)
            line
            Text(carrier.duration)
                .font(.regular12)
                .foregroundStyle(.appBlack)
            line
            Text(carrier.finishTime)
                .font(.regular17)
                .foregroundStyle(.appBlack)
        }
        .padding(14)
        .frame(maxWidth: .infinity)
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.appGray)
    }
}

#Preview {
    VStack(spacing: 20) {
        CarrierSelectionRowView(
            carrier: Carrier(
                carrierName: "РЖД",
                startTime: "22:30",
                finishTime: "08:15",
                duration: "20 часов",
                date: "14 января",
                connectingStation: "С пересадкой в Костроме",
                imageName: "rzd")
        )
        .padding(10)
        .background(Color.yellow)
        
        CarrierSelectionRowView(
            carrier: Carrier(
                carrierName: "РЖД",
                startTime: "22:30",
                finishTime: "08:15",
                duration: "20 часов",
                date: "14 января",
                connectingStation: nil,
                imageName: "rzd")
        )
        .padding(10)
        .background(Color.orange)
    }
}

#Preview("text") {
    HStack(alignment: .top) {
        Text("Левый")
            .font(.bold34)
        
        Spacer()
        
        VStack() {
            Text("Правый")
                .font(.regular12)
                .padding(.top, 1)
                .border(Color.red, width: 0.5)
        }
        .border(Color.red, width: 0.5)
    }
    .border(Color.blue, width: 0.5)
    .padding(10)
    .background(Color.yellow)
}

