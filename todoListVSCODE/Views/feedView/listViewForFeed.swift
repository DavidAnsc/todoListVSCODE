import SwiftUI

struct listViewForFeed: View {
	@State var newViewModel: listViewModel = listViewModel(todoList: [todoModel(title: "Sample Task 1", dueDate: Date(), isStarred: false, isPinned: false),
																  todoModel(title: "Sample Task 2", dueDate: Date(), isStarred: true, isPinned: false),
																  todoModel(title: "Sample Task 3", dueDate: Date(), isStarred: false, isPinned: true),
																  todoModel(title: "Sample Task 4", dueDate: Date(), isStarred: false, isPinned: true),
																  todoModel(title: "Sample Task 5", dueDate: Date(), isStarred: true, isPinned: false),
																  todoModel(title: "Sample Task 6", dueDate: Date(), isStarred: false, isPinned: false)])
	
	@Binding var normalCount: Int
	@Binding var pinnedCount: Int
	
	
	var body: some View {
		if newViewModel.todoList.filter({ $0.dueDate <= Date() && $0.isPinned }).count >= 1 {
			Section {
				ForEach(Array(newViewModel.todoList.enumerated()), id: \.offset) { index, item in
					if item.isPinned && (item.dueDate == Date() || item.dueDate < Date()) {
						ListRowView(item: item)
							.onAppear {
								pinnedCount += 1
							}
							.onDisappear {
								pinnedCount -= 1
							}
					} else {
						EmptyView()
					}
					
				}
				
			}
		}
		
		if newViewModel.todoList.filter({ $0.dueDate <= Date() && !$0.isPinned }).count >= 1 {
			Section {
				ForEach(Array(newViewModel.todoList.enumerated()), id: \.offset) { index, item in
					if !item.isPinned && (item.dueDate <= Date()) {
						ListRowView(item: item)
							.onAppear {
								normalCount += 1
							}
							.onDisappear {
								normalCount -= 1
							}
						// .onTapGesture {
						// 	withAnimation(.smooth(duration: 0.3)) {
						// 		normalViewModel.toggleCompletion(item: item)
						// 	}
						// 	// normalViewModel.toggleCompletion(item: item)
						// }
					} else {
						EmptyView()
					}
					
					
				}
				.onMove(perform: newViewModel.moveItem)
			}
			
		}
		
		
	}
}
