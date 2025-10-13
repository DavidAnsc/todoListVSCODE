import SwiftUI

struct ListView: View {
	@EnvironmentObject var normalViewModel: ListViewModel
	@State var normalCount = 0
	@State var pinnedCount = 0
	var body: some View {
		if normalViewModel.todoList.filter({ $0.isPinned && !$0.isHidden }).isEmpty && !normalViewModel.todoList.filter({ !$0.isPinned && !$0.isHidden }).isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if !item.isPinned && !item.isHidden {
						ListRowView(item: item)
							.onAppear {
								normalCount += 1
							}
							.onDisappear {
								normalCount -= 1
							}
					}
					
					
				}
			} header: {
				HStack(alignment: .top) {
					Label("Normal Tasks", systemImage: "flag.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color.blue.opacity(0.7))
						.font(.system(size: 12))
					
					Spacer()
					
					Text(normalCount == 1 || normalCount == 0 ? "\(normalViewModel.todoList.filter { !$0.isPinned }.count) ITEM" : "\(normalViewModel.todoList.filter { !$0.isPinned }.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
				
			}
			
			
			
			
		} else if normalViewModel.todoList.filter({ !$0.isPinned && !$0.isHidden }).isEmpty && !normalViewModel.todoList.filter({ $0.isPinned && !$0.isHidden }).isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if item.isPinned && !item.isHidden {
						ListRowView(item: item)
							.onAppear {
								pinnedCount += 1
							}
							.onDisappear {
								pinnedCount -= 1
							}
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
					Text(pinnedCount == 0 || pinnedCount == 1 ? "\(normalViewModel.todoList.filter { $0.isPinned }.count) ITEM" : "\(normalViewModel.todoList.filter { $0.isPinned }.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
			
			
			
		} else if !normalViewModel.todoList.filter({ $0.isPinned && !$0.isHidden }).isEmpty && !normalViewModel.todoList.filter({ !$0.isPinned && !$0.isHidden }).isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if item.isPinned && !item.isHidden {
						ListRowView(item: item)
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
			
			
			
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if !item.isPinned && !item.isHidden {
						ListRowView(item: item)
						// .onTapGesture {
						// 	withAnimation(.smooth(duration: 0.3)) {
						// 		normalViewModel.toggleCompletion(item: item)
						// 	}
						// 	// normalViewModel.toggleCompletion(item: item)
						// }
					}
					
					
				}
			} header: {
				HStack(alignment: .top) {
					Label("Normal Tasks", systemImage: "flag.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color.blue.opacity(0.7))
						.font(.system(size: 12))
					
					Spacer()
					
					Text(normalViewModel.todoList.filter { !$0.isPinned }.count == 1 || normalViewModel.todoList.filter { !$0.isPinned }.count == 0 ? "\(normalViewModel.todoList.filter { !$0.isPinned }.count) ITEM" : "\(normalViewModel.todoList.filter { !$0.isPinned }.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
				
			}
		}
		
		
		
		
		
		
	}
}
