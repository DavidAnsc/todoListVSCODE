import SwiftUI

struct completedView: View {
    @EnvironmentObject private var normalViewModel: listViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(normalViewModel.todoList.filter { $0.isDone == true }, id: \.id) { x in
                    listRowViewForComplete(todo: x)
                }

            }
            .navigationTitle("Completed Tasks")
        }
    }
}