import SwiftUI

struct ListView: View {
	@EnvironmentObject var normalViewModel: ListViewModel
	@Binding var showEditingBar: Bool
	var body: some View {
		if !normalViewModel.recentUnpinned.isEmpty && normalViewModel.recentPinned.isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if !item.isPinned && !item.isHidden {
						ListRowView(showEditingBar: $showEditingBar, item: item)
					} else {
						EmptyView()
					}
					
					
				}
			} header: {
				HStack(alignment: .top) {
					Label("Normal Tasks", systemImage: "flag.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color.blue.opacity(0.7))
						.font(.system(size: 12))
					
					Spacer()
					
					Text(normalViewModel.recentUnpinned.count == 1 || normalViewModel.recentUnpinned.count == 0 ? "\(normalViewModel.recentUnpinned.count) ITEM" : "\(normalViewModel.recentUnpinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
				
			}
			
			
			
			
		} else if normalViewModel.recentUnpinned.isEmpty && !normalViewModel.recentPinned.isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if item.isPinned && !item.isHidden {
						ListRowView(showEditingBar: $showEditingBar, item: item)
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
					Text(normalViewModel.recentPinned.count == 0 || normalViewModel.recentPinned.count == 1 ? "\(normalViewModel.recentPinned.count) ITEM" : "\(normalViewModel.recentPinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
			
			
			
		} else if !normalViewModel.recentUnpinned.isEmpty && !normalViewModel.recentPinned.isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if item.isPinned && !item.isHidden {
						ListRowView(showEditingBar: $showEditingBar, item: item)
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
					Text(normalViewModel.recentPinned.count == 0 || normalViewModel.recentPinned.count == 1 ? "\(normalViewModel.recentPinned.count) ITEM" : "\(normalViewModel.recentPinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
			
			
			
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if !item.isPinned && !item.isHidden {
						ListRowView(showEditingBar: $showEditingBar, item: item)
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
			} header: {
				HStack(alignment: .top) {
					Label("Normal Tasks", systemImage: "flag.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color.blue.opacity(0.7))
						.font(.system(size: 12))
					
					Spacer()
					
					Text(normalViewModel.recentUnpinned.count == 1 || normalViewModel.recentUnpinned.count == 0 ? "\(normalViewModel.recentUnpinned.count) ITEM" : "\(normalViewModel.recentUnpinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
				
			}
		}
		
		
		
		
		
		
	}
}
