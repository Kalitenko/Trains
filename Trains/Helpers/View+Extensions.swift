import SwiftUI

extension View {
    func horizontalStorySwipe(
        onLeft: @escaping () -> Void,
        onRight: @escaping () -> Void
    ) -> some View {
        gesture(
            DragGesture()
                .onEnded { value in
                    let dx = value.translation.width
                    if dx < -40 { onLeft() }
                    if dx > 40  { onRight() }
                }
        )
    }
}

struct TestSwipeView: View {
    var body: some View {
        Rectangle()
            .horizontalStorySwipe(onLeft: { print("next") }, onRight: { print("prev") })
    }
}

#Preview {
    TestSwipeView()
}
