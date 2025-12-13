import SwiftUI

struct StoryView: View {
    
    let story: Story
    @State private var currentIndex: Int = 0
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack{
            Color.appBlack.ignoresSafeArea()   
            image
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .scaleEffect(animate ? 1 : 0.5)
                .animation(.spring(response: 0.8, dampingFraction: 0.3), value: animate)
                .onAppear {
                    animate = true
                }
                .onDisappear {
                    animate = false
                }
            vStack
        }
        .background(.appBlack)
    }
    
    
    private var image: some View {
        Image(story.images[currentIndex])
            .resizable()
            .scaledToFill()
    }
    
    private var vStack: some View {
        VStack {
            Spacer()
            textPart
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
        }
        .scaleEffect(animate ? 1 : 1.5)
        .animation(.spring(response: 0.8, dampingFraction: 0.3), value: animate)
        .onAppear {
            animate = true
        }
        .onDisappear {
            animate = false
        }
    }
    
    private var textPart: some View {
        VStack(spacing: 16) {
            title
            description
        }
    }
    
    private var title: some View {
        Text(story.title)
            .font(.bold34)
            .foregroundColor(.appWhite)
            .lineLimit(2)
    }
    
    private var description: some View {
        Text(story.description)
            .font(.regular20)
            .foregroundColor(.appWhite)
            .lineLimit(3)
    }
}

#Preview {
    let story = StoriesViewModel().stories[1]
    StoryView(story: story)
}
