import SwiftUI

struct feedView: View {

    @State var normalListCount = 0
    @State var pinnedListCount = 0

    var body: some View {
        Text("hello")
        ScrollView(.horizontal) {
            HStack {
                listViewForFeed(normalCount: $normalListCount, pinnedCount: $pinnedListCount)
                .background(Color.red)
            }
        }
    }
}
