import SwiftUI

struct completedView: View {
    // TODO: Make this @State variable into an environment object
    @State var completedItems: [String] = ["item 1", "item 2", "item 3"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(completedItems, id: \.self) { x in
                    Text(x)
                }
            }
            .navigationTitle("Completed Tasks")
        }
    }
}