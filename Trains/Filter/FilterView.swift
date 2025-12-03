import SwiftUI

struct FilterView: View {
    
    @Binding var selectedTimeRanges: Set<DepartureTimeRange>
    @Binding var selectedOption: TransferOption?
    @Environment(\.dismiss) private var dismiss
    
    private var buttonIsEnabled: Bool {
        !selectedTimeRanges.isEmpty || selectedOption != nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            departureTimeSection
            transferSection
        }
        .backButtonToolbar(dismiss)
        Spacer()
        if buttonIsEnabled {
            PrimaryButton(title: "Применить",
                          action: {
                dismiss()
            })
            .padding(.bottom, 24)
        }
    }
    
    private var departureTimeSection: some View {
        Section(header: FilterHeaderView(header: "Время вылета")) {
            ForEach(DepartureTimeRange.allCases, id: \.self) { range in
                CheckItemView(text: range.rawValue,
                              isSelected: selectedTimeRanges.contains(range),
                              style: .square,
                              action: {
                    toggleTimeRange(range)
                })
            }
        }
    }
    
    private var transferSection: some View {
        Section(header: FilterHeaderView(header: "Показывать варианты с пересадками")) {
            ForEach(TransferOption.allCases, id: \.self) { option in
                CheckItemView(
                    text: option.rawValue,
                    isSelected: selectedOption == option,
                    style: .circle,
                ) {
                    if selectedOption == option {
                        selectedOption = nil
                    } else {
                        selectedOption = option
                    }
                }
            }
        }
    }
    
    private func toggleTimeRange(_ range: DepartureTimeRange) {
        if selectedTimeRanges.contains(range) {
            selectedTimeRanges.remove(range)
        } else {
            selectedTimeRanges.insert(range)
        }
    }
    
}

#Preview {
    NavigationStack {
        FilterView(selectedTimeRanges:  .constant([]), selectedOption:  .constant(nil))
    }
}
