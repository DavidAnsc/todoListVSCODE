import SwiftUI

struct completedView: View {
    // TODO: Make this @State variable into an environment object
    @EnvironmentObject private var normalViewModel: listViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(normalViewModel.todoList, id: \.id) { x in
                    listRowView(todo: x)
                }
            }
            .navigationTitle("Completed Tasks")
        }
    }
}