import SwiftUI

struct pinnedList: View {
	@EnvironmentObject var normalViewModel: listViewModel
	var body: some View {
		Section {


			// TODO: Fix the data saving problem for completion toggle.
			// The Item is not linked back to the original data source after
			// being changed.



			ForEach(Array(normalViewModel.todoList.filter { $0.isPinned }.enumerated()), id: \.offset) { index, item in
				listRowView(itemNum: index)
					.swipeActions(edge: .leading, allowsFullSwipe: false) {
						Button {
							normalViewModel.togglePin(item: item)
						} label: {
							Image(systemName: item.isPinned ? "pin.slash.fill" : "pin.fill")
								.foregroundStyle(item.isPinned ? Color.gray.opacity(0.4) : Color.blue)
						}
						.tint(item.isPinned ? Color(#colorLiteral(red: 0.5647058823529412, green: 0.5647058823529412, blue: 0.5647058823529412, alpha: 1.0)): Color.blue)
					}
					.swipeActions(edge: .trailing, allowsFullSwipe: true) {
						Button(role: .destructive) {
							normalViewModel.removeItem(item: item)
						} label: {
							Image(systemName: "trash")
						}
						.tint(Color.red)
						
						Button {
							normalViewModel.toggleStar(item: item)
						} label: {
							Image(systemName: item.isStarred ?  "star.slash" : "star.fill")
								.foregroundStyle(item.isStarred ? .white : .gray.opacity(0.4))
						}
						.tint(item.isStarred ? Color.gray : Color(#colorLiteral(red: 0.8666666666666667, green: 0.7843137254901961, blue: 0.054901960784313725, alpha: 1.0)))
					}
				
			}
			
		} header: {
			HStack(alignment: .top) {
				Label("Pinned Tasks", systemImage: "pin.fill")
					.padding(.bottom, 8)
					.foregroundStyle(Color.blue.opacity(0.7))
					.bold()
				
					.font(.system(size: 11))
				Spacer()
				Text("\(normalViewModel.todoList.filter { $0.isPinned }.count) ITEMS")
					.font(.system(size: 11))
					.foregroundStyle(Color.gray.opacity(0.7))
			}
		}
		
	}
}
