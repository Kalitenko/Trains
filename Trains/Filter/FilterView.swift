import SwiftUI

enum DepartureTimeRange: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

enum TransferOption: String, CaseIterable {
    case yes = "Да"
    case no = "Нет"
}

struct FilterView: View {
    
    @State private var selectedTimeRanges: Set<DepartureTimeRange> = []
    @State private var selectedOption: TransferOption? = nil
    
    private var buttonIsEnabled: Bool {
        !selectedTimeRanges.isEmpty || selectedOption != nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            departureTimeSection
            transferSection
        }
        Spacer()
        if buttonIsEnabled {
            PrimaryButton(title: "Применить",
                          action: {
                print("Применить tapped")
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
    FilterView()
}
