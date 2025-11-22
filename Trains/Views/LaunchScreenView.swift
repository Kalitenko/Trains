import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea(edges: .all)
                Image(.splashScreen)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
