import SwiftUI

struct pinnedList2: View {
	@EnvironmentObject var normalViewModel: listViewModel
	
	@Binding var pinnedCount: Int
	var body: some View {
		Section {
			ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
				if item.isPinned && (item.dueDate == Date() || item.dueDate < Date()) {
					listRowView(item: item)
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
}
