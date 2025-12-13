import SwiftUI

struct StoriesContentView: View {
    
    var stories: [Story] = []
    @Binding var currentStoryIndex: Int
    
    var onViewed: (Int) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { _, newIndex in
                    onViewed(newIndex)
                }
            closeButton
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    let dx = value.translation.width
                    let dy = value.translation.height
                    
                    guard abs(dy) > abs(dx) + 20 else { return }
                    
                    if dy < -40 {
                        dismiss()
                        print("dismiss")
                    }
                }
        )
    }
    
    private var closeButton: some View {
        RoundButton(
            systemName: "xmark",
            size: 30,
            iconColor: .appWhite,
            backgroundColor: .appBlack,
            action: {
                dismiss()
            }
        )
    }
}

#Preview {
    let stories: [Story] = StoriesViewModel().stories
    StoriesContentView(
        stories: stories, currentStoryIndex: .constant(3), onViewed: { index in print("Viewed story at: \(index)")}
    )
}
