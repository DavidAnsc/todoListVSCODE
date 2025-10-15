import SwiftUI

struct ListViewForToday: View {
	@EnvironmentObject var normalViewModel: ListViewModel
	@Binding var showEditingBar: Bool
	var body: some View {
		if !normalViewModel.todayPinned.isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if item.isPinned && (item.dueDate == Date() || item.dueDate < Date()) && item.isHidden == false {
						ListRowView(showEditingBar: $showEditingBar, item: item)
					} else {
						EmptyView()
					}
					
				}
				
			} header: {
				HStack(alignment: .top) {
					Label("Pinned Tasks", systemImage: "pin.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)).opacity(0.7))
						.bold()
					
						.font(.system(size: 12))
					Spacer()
					
					
					
					Text(normalViewModel.todayPinned.count == 1 || normalViewModel.todayPinned.count == 0 ? "\(normalViewModel.todayPinned.count) ITEM" : "\(normalViewModel.todayPinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
		}
		
		if !normalViewModel.todayUnpinned.isEmpty {
			Section {
				ForEach(normalViewModel.todoList, id: \.id) { item in
					if !item.isPinned && (item.dueDate <= Date()) && item.isHidden == false {
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
				.onMove(perform: normalViewModel.moveItem)
			} header: {
				HStack(alignment: .top) {
					Label("Normal Tasks", systemImage: "flag.fill")
						.padding(.bottom, 8)
						.foregroundStyle(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)).opacity(0.7))
						.font(.system(size: 12))
					
					Spacer()
					
					Text(normalViewModel.todayUnpinned.count == 1 || normalViewModel.todayUnpinned.count == 0 ? "\(normalViewModel.todayUnpinned.count) ITEM" : "\(normalViewModel.todayUnpinned.count) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
		}
		
		
	}
}
