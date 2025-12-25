import SwiftUI

struct CircularProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5)
    }
}

#Preview {
    CircularProgressView()
}
