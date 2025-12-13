import SwiftUI

struct StoriesContentView: View {
    
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    
    var onViewed: (Int) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(stories: stories, currentStoryIndex: $currentStoryIndex) {
                dismiss()
            }
            .onAppear {
                onViewed(currentStoryIndex)
            }
            .onChange(of: currentStoryIndex) { _, oldIndex in
                onViewed(oldIndex)
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
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State var stories = StoriesViewModel().stories
    @State var index = 0
    
    var body: some View {
        StoriesContentView(
            stories: stories,
            currentStoryIndex: $index,
            onViewed: { index in print("Viewed story at: \(index)")}
        )
    }
}

#Preview("short") {
    PreviewWrapperShort()
}

private struct PreviewWrapperShort: View {
    let stories: [Story] = [StoriesViewModel().stories[0], StoriesViewModel().stories[1]]
    @State var index = 0
    
    var body: some View {
        StoriesContentView(
            stories: stories,
            currentStoryIndex: $index,
            onViewed: { index in print("Viewed story at: \(index)")}
        )
    }
}

#Preview {
    let stories: [Story] = StoriesViewModel().stories
    StoriesContentView(
        stories: stories, currentStoryIndex: .constant(3), onViewed: { index in print("Viewed story at: \(index)")}
    )
}
