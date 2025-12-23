import SwiftUI

struct SettingsView: View {
    
    @AppStorage(AppStorageKey.isDarkTheme.rawValue) private var isDarkTheme: Bool = false
    @AppStorage(AppStorageKey.fewCities.rawValue) private var onlyFewCities: Bool = true
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack {
            darkTheme
            fewStations
            userAgreement
            Spacer()
            apiInfo
        }
        .padding(16)
        .appBackground()
    }
    
    private var darkTheme: some View {
        HStack {
            Text("Темная тема")
                .font(.regular17)
                .foregroundStyle(.appTextPrimary)
            Spacer()
            Toggle("", isOn: $isDarkTheme)
        }
        .frame(height: 60)
    }
    
    private var fewStations: some View {
        HStack {
            Text("Режим тестирования")
                .lineLimit(2)
                .font(.regular17)
                .foregroundStyle(.appTextPrimary)
            InfoLabel(text: "Использует только города: Москва, Минск, Смоленск, Санкт-Петербург, Караганды")
            Spacer()
            Toggle("", isOn: $onlyFewCities)
        }
        .frame(height: 60)
    }
    
    struct InfoLabel: View {
        let text: String
        @State private var showTooltip = false
        
        var body: some View {
            ZStack(alignment: .top) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        withAnimation { showTooltip.toggle() }
                    }
                
                if showTooltip {
                    Text(text)
                        .font(.footnote)
                        .padding(8)
                        .frame(maxWidth: 250, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .offset(y: -40)
                        .onTapGesture {
                            withAnimation { showTooltip = false }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                }            }
        }
    }
    
    private var userAgreement: some View {
        NavigationLink {
            AgreementView(networkMonitor: networkMonitor)
                .navigationTitle(Text("Пользовательское соглашение"))
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            HStack {
                Text("Пользовательское соглашение")
                    .font(.regular17)
                    .foregroundStyle(.appTextPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.appTextPrimary)
            }
            .frame(height: 60)
        }
    }
    
    private var apiInfo: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.regular12)
                .foregroundStyle(.appTextPrimary)
            Text("Версия 1.0 (beta)")
                .font(.regular12)
                .foregroundStyle(.appTextPrimary)
        }
        .padding(.bottom, Constants.customTabBarHeight + 24)
    }
}

#Preview {
    SettingsView()
        .environmentObject(NetworkMonitor())
}
