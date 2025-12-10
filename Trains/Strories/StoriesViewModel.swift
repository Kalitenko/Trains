import SwiftUI

@Observable class StoriesViewModel {
    
    var stories: [Story] = []
    
    private var previews: [ImageResource] = []
    private var storyPictures: [ImageResource] = []
    private let title = "Text Text Text Text Text Text Text Text Text Text"
    private let description = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    
    init() {
        initPreviews()
        initStoryPictures()
        initStories()
    }
    
    private func initPreviews() {
        previews = [.preview1, .preview2, .preview3, .preview4, .preview5, .preview6, .preview7]
    }
    
    private func initStoryPictures() {
        storyPictures = [
            .story1, .story2, .story3, .story4, .story5, .story6, .story7,
            .story8, .story9, .story10, .story11, .story12, .story13, .story14
        ]
    }
    
    private func initStories() {
        stories = previews.enumerated().map { index, preview in
            let left = index * 2
            let right = index * 2 + 1
            
            let images = Array(storyPictures[left...right])
            
            return Story(
                title: title,
                description: description,
                preview: preview,
                images: images,
                isViewed: false
            )
        }
    }
}
