import SwiftUI

struct AgreementView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @StateObject private var viewModel: AgreementViewModel
    
    init(networkMonitor: NetworkMonitor) {
        _viewModel = StateObject(wrappedValue: AgreementViewModel(networkMonitor: networkMonitor))
    }
    
    var body: some View {
        ParentContainer(error: $viewModel.error) {
            if let url = viewModel.url {
                WebView(url: url)
                    .navigationBarBackButtonHidden(true)
                    .backButtonToolbar(dismiss)
            } else {
                ErrorView(type: .configurationError)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    let monitor = NetworkMonitor()
    NavigationStack {
        AgreementView(networkMonitor: monitor)
    }
    .environmentObject(monitor)
}
