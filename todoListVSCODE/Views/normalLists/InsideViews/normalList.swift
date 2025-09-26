import SwiftUI

struct normalList: View {
	@EnvironmentObject var normalViewModel: listViewModel
	var body: some View {
		Section {
			ForEach(Array(normalViewModel.todoList.enumerated()), id: \.offset) { index, item in
				if !item.isPinned {
					listRowView(item: item)
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
