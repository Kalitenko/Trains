import SwiftUI

enum ErrorType {
    case serverError
    case noInternet
    case configurationError
    
    var imageResource: ImageResource {
        switch self {
        case .serverError: .serverError
        case .noInternet: .noInternet
        case .configurationError: .configurationError
        }
    }
    
    var text: String {
        switch self {
        case .serverError: "Ошибка сервера"
        case .noInternet: "Нет интернета"
        case .configurationError: "Что-то пошло не так"
        }
    }
}

struct ErrorView: View {
    
    let type: ErrorType
    let side: CGFloat?
    
    private let defaultSide: CGFloat = 223
    
    init(type: ErrorType, side: CGFloat? = nil) {
        self.type = type
        self.side = side
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(type.imageResource)
                .resizable()
                .scaledToFill()
                .frame(width: side ?? defaultSide,
                       height: side ?? defaultSide)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
            
            Text(type.text)
                .font(.bold24)
                .foregroundStyle(.appTextPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
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

#Preview("Configuration error") {
    ErrorView(type: .configurationError)
}


