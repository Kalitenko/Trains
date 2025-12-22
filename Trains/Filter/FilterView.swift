import SwiftUI

struct FilterView: View {
    
    @State var viewModel: CarrierSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var buttonIsEnabled: Bool {
        !viewModel.selectedTimeRanges.isEmpty || viewModel.selectedOption != nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            departureTimeSection
            transferSection
        }
        .backButtonToolbar(dismiss)
        Spacer()
        PrimaryButton(title: "Применить") {
            viewModel.applyFilters()
            dismiss()
        }
        .opacity(buttonIsEnabled ? 1 : 0)
        .padding(.bottom, 24)
    }
    
    private var departureTimeSection: some View {
        Section(header: FilterHeaderView(header: "Время вылета")) {
            ForEach(DepartureTimeRange.allCases, id: \.self) { range in
                CheckItemView(text: range.rawValue,
                              isSelected: viewModel.selectedTimeRanges.contains(range),
                              style: .square) {
                    toggleTimeRange(range)
                }
            }
        }
    }
    
    private var transferSection: some View {
        Section(header: FilterHeaderView(header: "Показывать варианты с пересадками")) {
            ForEach(TransferOption.allCases, id: \.self) { option in
                CheckItemView(
                    text: option.rawValue,
                    isSelected: viewModel.selectedOption == option,
                    style: .circle,
                ) {
                    if viewModel.selectedOption == option {
                        viewModel.selectedOption = nil
                    } else {
                        viewModel.selectedOption = option
                    }
                }
            }
        }
    }
    
    private func toggleTimeRange(_ range: DepartureTimeRange) {
        if viewModel.selectedTimeRanges.contains(range) {
            viewModel.selectedTimeRanges.remove(range)
        } else {
            viewModel.selectedTimeRanges.insert(range)
        }
    }
    
}

#Preview {
    NavigationStack {
        
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
        FilterView(viewModel: vm)
    }
}
