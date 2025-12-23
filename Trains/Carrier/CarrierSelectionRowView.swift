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
        Group {
            if let url = carrier.imageURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    placeholderImage
                }
            } else {
                placeholderImage
            }
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    private var placeholderImage: some View {
        Image(.carrierPlaceholder)
            .resizable()
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
            Text(carrier.durationText)
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
        Line(color: .appGray, height: 1)
    }
}

#Preview {
    VStack(spacing: 20) {
        CarrierSelectionRowView(
            carrier: Carrier(
                carrierName: "РЖД",
                departure: Calendar.current.date(
                    bySettingHour: 22,
                    minute: 30,
                    second: 0,
                    of: Date()
                )!,
                arrival: Calendar.current.date(
                    byAdding: .hour,
                    value: 10,
                    to: Calendar.current.date(
                        bySettingHour: 22,
                        minute: 30,
                        second: 0,
                        of: Date()
                    )!
                )!,
                duration: 20 * 60 * 60,
                connectingStation: "С пересадкой в Костроме",
                imageURL: nil,
                code: ""
            )
        )
        .padding(10)
        .background(Color.yellow)
        
        CarrierSelectionRowView(
            carrier: Carrier(
                carrierName: "РЖД",
                departure: Calendar.current.date(
                    bySettingHour: 22,
                    minute: 30,
                    second: 0,
                    of: Date()
                )!,
                arrival: Calendar.current.date(
                    bySettingHour: 8,
                    minute: 15,
                    second: 0,
                    of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
                )!,
                duration: (9 * 60 + 45) * 60,
                connectingStation: nil,
                imageURL: nil,
                code: ""
            )
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

