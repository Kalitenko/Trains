import SwiftUI

struct ErrorOverlayModifier: ViewModifier {
    
    let error: ErrorType?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(error == nil ? 1 : 0) // или убрать, если надо оставить позади
            
            if let error {
                ErrorView(type: error)
            }
        }
    }
}

extension View {
    func errorOverlay(_ error: ErrorType?) -> some View {
        self.modifier(ErrorOverlayModifier(error: error))
    }
}

struct SomeScreen: View {
    
    @State private var error: ErrorType? = nil
    
    var body: some View {
        content
            .errorOverlay(error)
    }
    
    private var content: some View {
        VStack {
            Text("Мой контент")
            Button("Ошибка сервера") {
                error = .serverError
            }
            
            Button("Нет интернета") {
                error = .noInternet
            }
            
            Button("Сбросить") {
                error = nil
            }
        }
    }
}

#Preview {
    SomeScreen()
}

