import SwiftUI

struct Story: Hashable {
    let title: String
    let description: String
    let preview: ImageResource
    let images: [ImageResource]
    var isViewed: Bool
}
