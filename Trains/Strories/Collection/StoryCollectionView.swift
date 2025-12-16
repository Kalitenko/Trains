import SwiftUI

struct StoryCollectionView: View {
    
    @Binding var stories: [Story]
    let onTapStory: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(stories.indices, id: \.self) { index in
                    StoryCollectionCell(story: stories[index])
                        .onTapGesture {
                            onTapStory(index)
                        }
                }
            }
            .frame(height: Constants.cellHeight)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let stories = StoriesViewModel().stories
    VStack {
        Spacer()
        StoryCollectionView(stories: .constant(stories), onTapStory: {
            index in print("Tapped on story at index: \(index)")
        })
            .padding(.horizontal, 16)
            .border(Color.red)
        Spacer()
    }
    .border(Color.yellow)
}
