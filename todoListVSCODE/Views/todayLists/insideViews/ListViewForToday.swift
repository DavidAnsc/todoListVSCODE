import SwiftUI

struct ListViewForToday: View {
	@EnvironmentObject var normalViewModel: ListViewModel
	
	@Binding var normalCount: Int
	@Binding var pinnedCount: Int
	
	
	var body: some View {
		if normalViewModel.todoList.filter({ $0.dueDate <= Date() && $0.isPinned && !$0.isHidden }).count >= 1 {
			Section {
				ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
					if item.isPinned && (item.dueDate == Date() || item.dueDate < Date()) && item.isHidden == false {
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
						.foregroundStyle(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)).opacity(0.7))
						.bold()
					
						.font(.system(size: 12))
					Spacer()
					Text(pinnedCount == 1 || pinnedCount == 0 ? "\(pinnedCount) ITEM" : "\(pinnedCount) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
		}
		
		if normalViewModel.todoList.filter({ $0.dueDate <= Date() && !$0.isPinned && !$0.isHidden }).count >= 1 {
			Section {
				ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
					if !item.isPinned && (item.dueDate <= Date()) && item.isHidden == false {
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
					
					Text(normalCount == 1 || normalCount == 0 ? "\(normalCount) ITEM" : "\(normalCount) ITEMS")
						.font(.system(size: 12))
						.foregroundStyle(Color.gray.opacity(0.7))
				}
			}
		}
		
		
	}
}
