import SwiftUI

enum ErrorType {
    case serverError
    case noInternet
    
    var imageName: String {
        switch self {
        case .serverError: "server_error"
        case .noInternet: "no_internet"
        }
    }

    var text: String {
        switch self {
        case .serverError: "Ошибка сервера"
        case .noInternet: "Нет интернета"
        }
    }
}

struct ErrorView: View {
    
    let type: ErrorType
    let side: CGFloat?

    private let defaultSide: CGFloat = 223

    var body: some View {
        VStack(spacing: 16) {
            Image(type.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: side ?? defaultSide,
                       height: side ?? defaultSide)

                Text(type.text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.appTextPrimary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
        }
    
    init(type: ErrorType, side: CGFloat? = nil) {
        self.type = type
        self.side = side
    }
}

#Preview("Server Error") {
    GeometryReader { proxy in
        ErrorView(type: .serverError,
                  side: proxy.size.width - 76 * 2)
    }
}

#Preview("No Internet") {
    ErrorView(type: .noInternet)
}


