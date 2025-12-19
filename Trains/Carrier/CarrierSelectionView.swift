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
                    if viewModel.carriers.isEmpty {
                        noOptionsText
                    }
                }
                
                .backButtonToolbar(dismiss)
                button
            }
            .fullScreenCover(isPresented: $viewModel.showFilters) {
                NavigationStack {
                    FilterView(
                        selectedTimeRanges: $viewModel.selectedTimeRanges,
                        selectedOption: $viewModel.selectedOption
                    )
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

#Preview {
    let whither = RoutePoint(settlement: "Москва", station: "Ярославский вокзал")
    let whence = RoutePoint(settlement: "Санкт Петербург", station: "Балтийский вокзал")
    let monitor = NetworkMonitor()
    
    let vm = CarrierSelectionViewModel(
        whither: whither,
        whence: whence,
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

