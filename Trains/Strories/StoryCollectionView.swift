import SwiftUI

struct StoryCollectionView: View {
    
    @Binding var stories: [Story]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 12) {
                ForEach(stories.indices, id: \.self) { index in
                    StoryCollectionCell(story: stories[index])
                }
            }
            .frame(height: Constants.cellHeight)
        }
    }
}

#Preview {
    let stories = StoriesViewModel().stories
    VStack {
        Spacer()
        StoryCollectionView(stories: .constant(stories))
            .padding(.horizontal, 16)
            .border(Color.red)
        Spacer()
    }
    .border(Color.yellow)
}
