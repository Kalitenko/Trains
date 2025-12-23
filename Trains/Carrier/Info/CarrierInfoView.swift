import SwiftUI

struct CarrierInfoView: View {
    
    @State private var viewModel: CarrierInfoViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: CarrierInfoViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ParentContainer(error: $viewModel.error) {
            VStack(alignment: .leading, spacing: 16) {
                image
                name
                contacts
                Spacer()
            }
            .padding(16)
            .appBackground()
            .navigationTitle("Информация о перевозчике")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .backButtonToolbar(dismiss)
        }
        .task {
            await viewModel.loadInfo()
        }
    }
    
    private var image: some View {
        Group {
            if let url = viewModel.imageURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    placeholderImage
                }
            } else {
                placeholderImage
            }
        }
    }
    
    private var placeholderImage: some View {
        Image(.carrierPlaceholder)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
    
    private var name: some View {
        Text(viewModel.carrierName)
            .font(.bold24)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var contacts: some View {
        VStack(alignment: .leading, spacing: 16) {
            ContactView(title: .email, subtitle: viewModel.email)
            ContactView(title: .phone, subtitle: viewModel.phone)
        }
    }
}

#Preview("RZD") {
    let monitor = NetworkMonitor()
    let vm = CarrierInfoViewModel(
        code: "xxx",
        system: nil,
        service: LocalCarrierInfoService(fileName: LocalCarrier.rzd.fileName),
        networkMonitor: monitor)
    
    NavigationStack {
        CarrierInfoView(viewModel: vm)
            .border(Color.red)
    }
    .preferredColorScheme(.dark)
}

#Preview("Aeroflot") {
    let monitor = NetworkMonitor()
    let vm = CarrierInfoViewModel(
        code: "xxx",
        system: nil,
        service: LocalCarrierInfoService(fileName: LocalCarrier.aeroflot.fileName),
        networkMonitor: monitor)
    
    NavigationStack {
        CarrierInfoView(viewModel: vm)
            .border(Color.red)
    }
    .preferredColorScheme(.dark)
}

#Preview("Turkish Airlines") {
    let monitor = NetworkMonitor()
    let vm = CarrierInfoViewModel(
        code: "xxx",
        system: nil,
        service: LocalCarrierInfoService(fileName: LocalCarrier.turkishAirlines.fileName),
        networkMonitor: monitor)
    
    NavigationStack {
        CarrierInfoView(viewModel: vm)
            .border(Color.red)
    }
    .preferredColorScheme(.dark)
}

#Preview("carrier logo") {
    Image(.fgk)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
}
