import SwiftUI

struct normalList: View {
	
	@EnvironmentObject var normalViewModel: listViewModel
	var body: some View {
		
		Section {
			ForEach(normalViewModel.todoList.filter { !$0.isPinned }) { item in
				@Bindable var Item = item
				listRowView(isDone: $Item.isDone, isStarred: item.isStarred, title: item.title)
					// .onTapGesture {
					// 	withAnimation(.smooth(duration: 0.3)) {
					// 		normalViewModel.toggleCompletion(item: item)
					// 	}
					// 	// normalViewModel.toggleCompletion(item: item)
					// }
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
			.onMove(perform: normalViewModel.moveItem)
		} header: {
			HStack(alignment: .top) {
				Label("Normal Tasks", systemImage: "flag.fill")
					.padding(.bottom, 8)
					.foregroundStyle(Color.blue.opacity(0.7))
					.font(.system(size: 11))
				
				Spacer()
				
				Text("\(normalViewModel.todoList.filter { !$0.isPinned }.count) ITEMS")
					.font(.system(size: 11))
					.foregroundStyle(Color.gray.opacity(0.7))
			}
			
		}
		
	}
}
