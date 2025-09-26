import SwiftUI

struct pinnedList: View {
	@EnvironmentObject var normalViewModel: listViewModel
	var body: some View {
		Section {


			// TODO: Fix the data saving problem for completion toggle.
			// The Item is not linked back to the original data source after
			// being changed.



			ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
				if item.isPinned {
					listRowView(item: item)
				} else {
					EmptyView()
				}
				
			}
			
		} header: {
			HStack(alignment: .top) {
				Label("Pinned Tasks", systemImage: "pin.fill")
					.padding(.bottom, 8)
					.foregroundStyle(Color.blue.opacity(0.7))
					.bold()
				
					.font(.system(size: 12))
				Spacer()
				Text(normalViewModel.todoList.filter { $0.isPinned }.count == 0 || normalViewModel.todoList.filter { $0.isPinned }.count == 1 ? "\(normalViewModel.todoList.filter { $0.isPinned }.count) ITEM" : "\(normalViewModel.todoList.filter { $0.isPinned }.count) ITEMS")
					.font(.system(size: 12))
					.foregroundStyle(Color.gray.opacity(0.7))
			}
		}
		
	}
}
