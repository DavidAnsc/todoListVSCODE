//
//  feedColumn.swift
//  todoListVSCODE
//
//  Created by David An on 2025-10-12.
//

import SwiftUI

struct feedColumn: View {
	@Binding var newViewModel: ListViewModel
	
	let item: TodoModel
	let index: Int
	
	@State var completion: Bool = false
	
	
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 32)
				.frame(width: 260, height: 230)
				.foregroundStyle(Color(#colorLiteral(red: 0.869410336, green: 0.9378909469, blue: 0.9392147064, alpha: 1)))
			RoundedRectangle(cornerRadius: 32)
				.stroke(lineWidth: 2)
				.frame(width: 260, height: 230)
				.foregroundStyle(Color(#colorLiteral(red: 0.7856250405, green: 0.7856250405, blue: 0.7856250405, alpha: 1)))
		}
		.onAppear {
			completion = newViewModel.todoList[index].isDone
		}
		.overlay {
			VStack(alignment: .leading) {
				HStack {
					Image(systemName: item.isStarred ? "star.fill" : "star")
						.font(.system(size: 19))
						.foregroundStyle(Color(#colorLiteral(red: 1, green: 0.5718008876, blue: 0, alpha: 1)))
						.bold()
						.padding(.leading, 4)
					
					Image(systemName: item.isPinned ? "pin.fill" : "pin")
						.font(.system(size: 18))
						.foregroundStyle(Color.blue)
				}
				.padding(.top, 15)
				
				
				Text(item.title)
					.font(.title)
					.bold()
					.fontDesign(.monospaced)
					.padding(.top, 10)
					.padding(.bottom, 0)
				
				if #available(iOS 26.0, *) {
					Text(item.notes)
						.font(Font.default)
						.fontDesign(.rounded)
				} else {
					// Fallback on earlier versions
				}
				
				
				Spacer()
				
				
				HStack {
					ZStack {
						Rectangle()
							.fill(LinearGradient(
								gradient: Gradient(colors: [Color.red.opacity(0.64), Color.pink.opacity(0.9)]),
								startPoint: .bottomLeading,
								endPoint: .topTrailing
							))
							.opacity(completion ? 0 : 1)
						
						Rectangle()
							.fill(LinearGradient(
								gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.8)]),
								startPoint: .bottomLeading,
								endPoint: .topTrailing
							))
							.opacity(completion ? 1 : 0)
						
						Text("In Progress")
							.bold()
							.opacity(completion ? 0 : 1)
						Text("Done")
							.bold()
							.opacity(completion ? 1 : 0)
					}
					.onTapGesture {
						withAnimation(.smooth(duration: 0.3)) {
							completion.toggle()
						}
					}
					.frame(width: 120, height: 100)
					.mask {
						RoundedRectangle(cornerRadius: 28)
							.frame(width: completion ? 120 : 100, height: completion ? 80 : 80)
						
							.animation(.easeInOut(duration: 0.3), value: completion)
							.clipShape(RoundedRectangle(cornerRadius: 28))
					}
					.padding(.leading, 5)
					
					
//					Spacer()
					
					
					Text(Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!) ? "Tomorrow" : Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!) ? "Today" : item.dueDate.formatted(date: .numeric, time: .omitted))
						.font(.system(size: 20))
						.bold()
						.fontDesign(.monospaced)
						.padding(.vertical, 1)
						.frame(width: 120, height: 80)
						.background(
							RoundedRectangle(cornerRadius: 28)
								.fill(Calendar.current.isDate(item.dueDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!) ? Color.teal.opacity(0.3) : Color.gray.opacity(0.15))
						)
						.fontWeight(.regular)
				}
				.frame(width: 220)
				.padding(.vertical, 6)
				
				
				
				
			}
		}
			
		
    }
}

#Preview {
	@Previewable let item: TodoModel = TodoModel(title: "Sample Task 3", dueDate: Date.now.addingTimeInterval(86400), isStarred: false, isPinned: true)
	@Previewable let index: Int = 2
	@Previewable @State var newViewModel = ListViewModel(todoList: [TodoModel(title: "sample 1", notes: "hello this is the note part", isStarred: false, isPinned: true),
										  TodoModel(title: "Sample Task 2", dueDate: Date(), isStarred: true, isPinned: false),
											TodoModel(title: "Sample Task 3", dueDate: Date.now.addingTimeInterval(86400), isStarred: false, isPinned: true),
										  TodoModel(title: "Sample Task 4", dueDate: Date(), isStarred: false, isPinned: true),
										  TodoModel(title: "Sample Task 5", dueDate: Date(), isStarred: true, isPinned: false),
										  TodoModel(title: "Sample Task 6", dueDate: Date(), isStarred: false, isPinned: false)])
	feedColumn(newViewModel: $newViewModel, item: item, index: index)
}
