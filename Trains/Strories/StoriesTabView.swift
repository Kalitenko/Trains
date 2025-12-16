import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                StoryView(story: story)
                    .zIndex(index == currentStoryIndex ? 1 : 0)
                    .id(index)
                    .tag(index)
                    .horizontalStorySwipe(
                        onLeft: { didTapPrev() },
                        onRight: { didTapNext() }
                    )
                    .overlay {
                        HStack {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { didTapPrev() }
                            
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { didTapNext() }
                        }
                    }
                
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func didTapNext() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
    
    func didTapPrev() {
        currentStoryIndex = max(currentStoryIndex - 1, 0)
    }
}


#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State var stories = StoriesViewModel().stories
    @State var index = 5
    
    var body: some View {
        StoriesTabView(
            stories: stories,
            currentStoryIndex: $index
        )
    }
}

#Preview {
    let stories: [Story] = StoriesViewModel().stories
    StoriesTabView(stories: stories, currentStoryIndex: .constant(3))
}
