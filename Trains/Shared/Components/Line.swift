import SwiftUI

struct Line: View {
    
    let color: Color
    let height: CGFloat
    
    var body: some View {
            Rectangle()
                .frame(height: height)
                .foregroundStyle(color)
        }
}

#Preview {
    Line(color: .appSeparator, height: 0.5)
}
