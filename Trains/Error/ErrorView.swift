import SwiftUI

enum ErrorType {
    case serverError
    case noInternet
    
    var imageResource: ImageResource {
        switch self {
        case .serverError: .serverError
        case .noInternet: .noInternet
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
    
    init(type: ErrorType, side: CGFloat? = nil) {
        self.type = type
        self.side = side
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(type.imageResource)
                .resizable()
                .scaledToFit()
                .frame(width: side ?? defaultSide,
                       height: side ?? defaultSide)
            
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


