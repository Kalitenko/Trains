import SwiftUI

struct CarrierSelectionView: View {
    
    @State private var viewModel: CarrierSelectionViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: CarrierSelectionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ParentContainer(error: $viewModel.error) {
            ZStack(alignment: .bottom) {
                VStack {
                    titleView
                    list
                }
                .background(Color.appBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                    if viewModel.filteredCarriers.isEmpty {
                        noOptionsText
                    }
                }
                
                .backButtonToolbar(dismiss)
                button
            }
            .task {
                await viewModel.loadSchedule()
            }
            .fullScreenCover(isPresented: $viewModel.showFilters) {
                NavigationStack {
                    FilterView(viewModel: viewModel)
                }
            }
        }
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .font(.bold24)
            .padding(.horizontal, 16)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var noOptionsText: some View {
        Text("Вариантов нет")
            .font(.bold24)
            .foregroundStyle(.appTextPrimary)
    }
    
    private var list: some View {
        
        List(viewModel.filteredCarriers, id: \.self) { carrier in
            Button {
                viewModel.onSelect(carrier)
            } label: {
                CarrierSelectionRowView(carrier: carrier)
                
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.appBackground)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        }
        
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .padding(.bottom, 80)
    }
    
    private var button: some View {
        PrimaryButton(
            title: "Уточнить время",
            showDot: isDotShown
        ) {
            viewModel.showFilters = true
        }
    }
    
    private var isDotShown: Bool {
        viewModel.selectedOption != nil || !viewModel.selectedTimeRanges.isEmpty
    }
}

#Preview("1") {
    let whither = RoutePoint(settlement: "Москва", station: StationItem(id: "", title: "СТАНЦИЯ"))
    let whence = RoutePoint(settlement: "Караганда", station: StationItem(id: "", title: "???"))
    let monitor = NetworkMonitor()
    
    let client = APIClientFactory.makeClient()
    
    let vm = CarrierSelectionViewModel(
        whither: whither,
        whence: whence,
        scheduleBetweenStationsServiceService: LocalScheduleBetweenStationsService(fileName: LocalRoute.moscowKaraganda.fileName),
        networkMonitor: monitor,
        onSelect: { carrier in
            print("Выбран перевозчик \(carrier.carrierName)")
        }
    )
    
    NavigationStack {
        CarrierSelectionView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
    .environmentObject(monitor)
}

#Preview("2") {
    let whither = RoutePoint(settlement: "Симферополь", station: StationItem(id: "", title: "СТАНЦИЯ"))
    let whence = RoutePoint(settlement: "Москва", station: StationItem(id: "", title: "СТАНЦИЯ"))
    let monitor = NetworkMonitor()
    
    let client = APIClientFactory.makeClient()
    
    let vm = CarrierSelectionViewModel(
        whither: whither,
        whence: whence,
        scheduleBetweenStationsServiceService: LocalScheduleBetweenStationsService(fileName: LocalRoute.simferopolMoscow.fileName),
        networkMonitor: monitor,
        onSelect: { carrier in
            print("Выбран перевозчик \(carrier.carrierName)")
        }
    )
    
    NavigationStack {
        CarrierSelectionView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
    .environmentObject(monitor)
}


#Preview("3") {
    let whither = RoutePoint(settlement: "Москва", station: StationItem(id: "", title: "СТАНЦИЯ"))
    let whence = RoutePoint(settlement: "Санкт-Петербург", station: StationItem(id: "", title: "СТАНЦИЯ"))
    let monitor = NetworkMonitor()
    
    let client = APIClientFactory.makeClient()
    
    let vm = CarrierSelectionViewModel(
        whither: whither,
        whence: whence,
        scheduleBetweenStationsServiceService: LocalScheduleBetweenStationsService(fileName: LocalRoute.moscowSaintPetersburg.fileName),
        networkMonitor: monitor,
        onSelect: { carrier in
            print("Выбран перевозчик \(carrier.carrierName)")
        }
    )
    
    NavigationStack {
        CarrierSelectionView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
    .environmentObject(monitor)
}
