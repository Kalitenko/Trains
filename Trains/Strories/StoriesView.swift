import SwiftUI

struct StoriesView: View {
    
    let stories: [Story]
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    @Binding var currentStoryIndex: Int
    @State var currentProgress: CGFloat
    let onFinished: () -> Void
    
    private var progress: CGFloat { CGFloat(currentStoryIndex) / CGFloat(stories.count) }
    
    init(stories: [Story], currentStoryIndex: Binding<Int>, onFinished: @escaping () -> Void) {
        self.stories = stories
        self._currentStoryIndex = currentStoryIndex
        self.onFinished = onFinished
        let initialProgress = TimerConfiguration(storiesCount: stories.count)
            .progress(for: currentStoryIndex.wrappedValue)
        
        self._currentProgress = State(initialValue: initialProgress)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                }
            
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let lastIndex = stories.count - 1
        
        let lastStoryEndProgress = 1.0
        
        if currentStoryIndex == lastIndex {
            if newProgress >= lastStoryEndProgress {
                onFinished()
            }
            return
        }
        
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State var stories = StoriesViewModel().stories
    @State var index = 3
    @State var isFinished = false
    
    var body: some View {
        StoriesView(
            stories: stories,
            currentStoryIndex: $index,
            onFinished: { print ("Finished")}
        )
    }
}
