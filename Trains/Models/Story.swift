import SwiftUI

struct Story: Hashable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let preview: ImageResource
    let images: [ImageResource]
    var isViewed: Bool
}
