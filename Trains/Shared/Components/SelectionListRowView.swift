import SwiftUI

struct SelectionListRowView: View {
    
    let title: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.appTextPrimary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.appTextPrimary)
        }
        .background(Color.appBackground)
    }
}

#Preview {
    SelectionListRowView(title: "I'm a row")
        .padding(10)
        .background(Color.yellow)
}
