import SwiftUI

struct SettingsView: View {
    
    @AppStorage(AppStorageKey.isDarkTheme.rawValue) private var isDarkTheme: Bool = false
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack {
            darkTheme
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
