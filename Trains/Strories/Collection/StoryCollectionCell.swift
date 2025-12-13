import SwiftUI

struct StoryCollectionCell: View {
    
    var story: Story
    
    var body: some View {
        ZStack {
            image
            VStack {
                Spacer()
                text
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 92, height: Constants.cellHeight)
        .overlay(
            border
        )
    }
    
    private var image: some View {
        Image(story.preview)
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .opacity(story.isViewed ? 0.5 : 1.0)
    }
    
    private var text: some View {
        Text(story.title)
            .font(.regular12)
            .foregroundColor(.appWhite)
            .lineLimit(3)
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: 16)
            .inset(by: 2)
            .stroke(story.isViewed ? .clear : .appBlue, lineWidth: 4)
    }
}

#Preview {
    let story1 = Story(id: UUID(),
                       title: "Title",
                      description: "Description",
                      preview: .preview7,
                      images: [.story13, .story14],
                      isViewed: false
    )
    let story2 = Story(id: UUID(),
                       title: "Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title ",
                      description: "Description",
                      preview: .preview8,
                      images: [.story15, .story16],
                      isViewed: true
    )
    let story3 = Story(id: UUID(),
                       title: "Title",
                      description: "Description",
                      preview: .preview9,
                      images: [.story17, .story18],
                      isViewed: false
    )
    HStack {
        StoryCollectionCell(story: story1)
        StoryCollectionCell(story: story2)
        StoryCollectionCell(story: story3)
    }
    .border(Color.red)
}
